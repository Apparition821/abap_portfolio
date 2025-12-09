CLASS lhc_zlc_r_Employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.

    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Request~ValidateDates.

    METHODS notenoughdaysleft FOR VALIDATE ON SAVE
      IMPORTING keys FOR Request~NotEnoughDaysLeft.

    METHODS determinestatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Request~DetermineStatus.

    METHODS determinedaysoff FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Request~DetermineDaysOff.

ENDCLASS.

CLASS lhc_zlc_r_Employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validatedates.

    DATA message TYPE REF TO zlc_cm_employee.

    READ ENTITY IN LOCAL MODE zlc_r_req
         FIELDS ( StartDate EndDate )
         WITH CORRESPONDING #( keys )
         RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-EndDate < request-StartDate.

        message = NEW zlc_cm_employee( textid = zlc_cm_employee=>invalid_dates ).

        APPEND VALUE #( %tky = request-%tky
                        %msg = message ) TO reported-request.

        APPEND VALUE #( %tky = request-%tky ) TO failed-request.

      ENDIF.

      IF request-StartDate+0(4) <> request-EndDate+0(4).

        message = NEW zlc_cm_employee( textid = zlc_cm_employee=>different_years ).

        APPEND VALUE #( %tky = request-%tky
                        %msg = message ) TO reported-request.

        APPEND VALUE #( %tky = request-%tky ) TO failed-request.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

METHOD notenoughdaysleft.
    DATA message TYPE REF TO zlc_cm_employee.
    DATA lv_pattern TYPE string.
    DATA lv_annual_leave TYPE i.
    DATA lv_sum_existing TYPE i.
    DATA lv_current_days TYPE i.

    READ ENTITY IN LOCAL MODE zlc_r_req
         FIELDS ( StartDate EndDate LeaveDays ApplicantUuid RequestUuid )
         WITH CORRESPONDING #( keys )
         RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-StartDate IS INITIAL.
        CONTINUE.
      ENDIF.

      DATA(current_year) = request-StartDate(4).

      SELECT SINGLE AnnualLeave
        FROM zlc_r_ent
        WHERE EmployeeUuid = @request-ApplicantUuid
          AND CurrentYear  = @current_year
        INTO @lv_annual_leave.

      IF sy-subrc <> 0.
        lv_annual_leave = 0.
      ENDIF.

      lv_pattern = current_year && '%'.

      SELECT SINGLE SUM( leave_days )
        FROM zlc_req
        WHERE applicant_uuid = @request-ApplicantUuid
          AND start_date     LIKE @lv_pattern
          AND status         <> 'R'               " 排除已拒绝
          AND request_uuid   <> @request-RequestUuid " 排除自己
        INTO @lv_sum_existing.

      lv_current_days = request-LeaveDays.

      IF ( lv_sum_existing + lv_current_days ) > lv_annual_leave.

        message = NEW zlc_cm_employee(
            textid = zlc_cm_employee=>not_enough_days_left
            remaining_leave_days = lv_annual_leave - lv_sum_existing
            requested_leave_days = lv_current_days ).

        APPEND VALUE #( %tky = request-%tky
                        %msg = message ) TO reported-request.

        APPEND VALUE #( %tky = request-%tky ) TO failed-request.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

METHOD determinestatus.
    READ ENTITY IN LOCAL MODE zlc_r_req
         FIELDS ( Status )
         WITH CORRESPONDING #( keys )
         RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      IF request-Status = 'B'.
        CONTINUE.
      ENDIF.

      MODIFY ENTITY IN LOCAL MODE zlc_r_req
           UPDATE FIELDS ( Status )
           WITH VALUE #( ( %tky   = request-%tky
                           Status = 'B' ) ).
    ENDLOOP.
  ENDMETHOD.

 METHOD determinedaysoff.

    READ ENTITY IN LOCAL MODE zlc_r_req
         FIELDS ( StartDate EndDate )
         WITH CORRESPONDING #( keys )
         RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).
      DATA(leave_days) = 0.

      IF request-StartDate IS INITIAL OR request-EndDate IS INITIAL OR request-EndDate < request-StartDate.
        CONTINUE.
      ENDIF.

      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          leave_days = calendar->calc_workingdays_between_dates(
                                    iv_start = request-StartDate
                                    iv_end   = request-EndDate ).

      CATCH cx_fhc_runtime.
          leave_days = ( request-EndDate - request-StartDate ) + 1.
      ENDTRY.

      IF leave_days <= 0.
         leave_days = ( request-EndDate - request-StartDate ) + 1.
      ENDIF.

      IF request-LeaveDays <> leave_days.
        MODIFY ENTITY IN LOCAL MODE zlc_r_req
               UPDATE FIELDS ( LeaveDays )
               WITH VALUE #( ( %tky      = request-%tky
                               LeaveDays = leave_days ) ).
      ENDIF.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
