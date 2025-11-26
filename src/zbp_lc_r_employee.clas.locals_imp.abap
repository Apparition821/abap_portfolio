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

    READ ENTITY IN LOCAL MODE zlc_r_req
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).

      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(leave_days) = ( calendar->calc_workingdays_between_dates( iv_start = request-StartDate iv_end = request-EndDate ) + 1 ) .
        CATCH cx_fhc_runtime.
          CONTINUE.
      ENDTRY.

      SELECT SINGLE FROM zlc_r_ent FIELDS RemainingDays WHERE CurrentYear = @request-StartDate+0(4) INTO @DATA(remaining_days).

      IF remaining_days < leave_days.
        message = NEW zlc_cm_employee( textid = zlc_cm_employee=>not_enough_days_left
                                         remaining_leave_days = remaining_days
                                         requested_leave_days = leave_days ).

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
           WITH VALUE #( FOR key IN keys
                         ( %tky   = key-%tky
                           Status = 'B' ) ).

    ENDLOOP.
  ENDMETHOD.

  METHOD determinedaysoff.

    READ ENTITY IN LOCAL MODE zlc_r_req
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(requests).

    LOOP AT requests INTO DATA(request).

      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(leave_days) = ( calendar->calc_workingdays_between_dates( iv_start = request-StartDate iv_end = request-EndDate ) + 1 ) .
        CATCH cx_fhc_runtime.
          CONTINUE.
      ENDTRY.

      IF request-LeaveDays = leave_days.
        CONTINUE.
      ENDIF.

      MODIFY ENTITY IN LOCAL MODE zlc_r_req
             UPDATE FIELDS ( LeaveDays )
             WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             LeaveDays = leave_days
                             %control-LeaveDays = if_abap_behv=>mk-on ) ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
