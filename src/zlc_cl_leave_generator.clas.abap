CLASS zlc_cl_leave_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zlc_cl_leave_generator IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.
    DATA ls_hans_maier TYPE zlc_employee.
    DATA ls_lisa_mueller TYPE zlc_employee.
    DATA ls_petra_schmid TYPE zlc_employee.
    DATA lt_employee TYPE TABLE OF zlc_employee.

    DATA ls_ent TYPE zlc_ent.
    DATA lt_ent TYPE TABLE OF zlc_ent.

    DATA ls_req TYPE zlc_req.
    DATA lt_req TYPE TABLE OF zlc_req.

    DELETE FROM zlc_employee.
    out->write( |Deleted Employees: { sy-dbcnt }| ).

    DELETE FROM zlc_ent.
    out->write( |Deleted Employees: { sy-dbcnt }| ).

    DELETE FROM zlc_req.
    out->write( |Deleted Employees: { sy-dbcnt }| ).

    ls_hans_maier-client = sy-mandt.
    ls_hans_maier-employee_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_hans_maier-created_by = 'GENERATOR'.
    ls_hans_maier-last_changed_by = 'GENERATOR'.
    ls_hans_maier-employee_id = '000001'.
    ls_hans_maier-first_name = 'Hans'.
    ls_hans_maier-last_name = 'Maier'.
    ls_hans_maier-entry_date = '20000501'.


    GET TIME STAMP FIELD ls_hans_maier-created_at.
    GET TIME STAMP FIELD ls_hans_maier-last_change_at.

    APPEND ls_hans_maier TO lt_employee.

    ls_ent-client = sy-mandt.
    ls_ent-entitlement_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_ent-created_by = 'GENERATOR'.
    ls_ent-last_changed_by = 'GENERATOR'.
    ls_ent-employee_uuid = ls_hans_maier-employee_uuid.
    ls_ent-current_year = '2025'.
    ls_ent-annual_leave = '30'.


    GET TIME STAMP FIELD ls_ent-created_at.
    GET TIME STAMP FIELD ls_ent-last_changed_at.
    APPEND ls_ent TO lt_ent.

    ls_ent-client = sy-mandt.
    ls_ent-entitlement_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_ent-created_by = 'GENERATOR'.
    ls_ent-last_changed_by = 'GENERATOR'.
    ls_ent-employee_uuid = ls_hans_maier-employee_uuid.
    ls_ent-current_year = '2026'.
    ls_ent-annual_leave = '30'.

    GET TIME STAMP FIELD ls_ent-created_at.
    GET TIME STAMP FIELD ls_ent-last_changed_at.
    APPEND ls_ent TO lt_ent.

    ls_lisa_mueller-client = sy-mandt.
    ls_lisa_mueller-employee_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_lisa_mueller-created_by = 'GENERATOR'.
    ls_lisa_mueller-last_changed_by = 'GENERATOR'.
    ls_lisa_mueller-employee_id = '000002'.
    ls_lisa_mueller-first_name = 'Lisa'.
    ls_lisa_mueller-last_name = 'Müller'.
    ls_lisa_mueller-entry_date = '20100701'.
    GET TIME STAMP FIELD ls_lisa_mueller-created_at.
    GET TIME STAMP FIELD ls_lisa_mueller-last_change_at.

    APPEND ls_lisa_mueller TO lt_employee.

    ls_ent-client = sy-mandt.
    ls_ent-entitlement_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_ent-created_by = 'GENERATOR'.
    ls_ent-last_changed_by = 'GENERATOR'.
    ls_ent-employee_uuid = ls_lisa_mueller-employee_uuid.
    ls_ent-current_year = '2026'.
    ls_ent-annual_leave = '30'.

    GET TIME STAMP FIELD ls_ent-created_at.
    GET TIME STAMP FIELD ls_ent-last_changed_at.
    APPEND ls_ent TO lt_ent.


    ls_petra_schmid-client = sy-mandt.
    ls_petra_schmid-employee_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_petra_schmid-created_by = 'GENERATOR'.
    ls_petra_schmid-last_changed_by = 'GENERATOR'.
    ls_petra_schmid-employee_id = '000003'.
    ls_petra_schmid-first_name = 'Petra'.
    ls_petra_schmid-last_name = 'Schmid'.
    ls_petra_schmid-entry_date = '20231001'.
    GET TIME STAMP FIELD ls_petra_schmid-created_at.
    GET TIME STAMP FIELD ls_petra_schmid-last_change_at.

    APPEND ls_petra_schmid TO lt_employee.

    ls_ent-client = sy-mandt.
    ls_ent-entitlement_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_ent-created_by = 'GENERATOR'.
    ls_ent-last_changed_by = 'GENERATOR'.
    ls_ent-employee_uuid = ls_petra_schmid-employee_uuid.
    ls_ent-current_year = '2026'.
    ls_ent-annual_leave = '7'.
    GET TIME STAMP FIELD ls_ent-created_at.
    GET TIME STAMP FIELD ls_ent-last_changed_at.
    APPEND ls_ent TO lt_ent.

    ls_req-client = sy-mandt.
    ls_req-request_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_req-created_by = 'GENERATOR'.
    ls_req-last_changed_by = 'GENERATOR'.
    ls_req-applicant_uuid = ls_hans_maier-employee_uuid.
    ls_req-start_date = '20250701'.
    ls_req-end_date = '20250710'.
    ls_req-leave_days = '8'.
    ls_req-approver_uuid = ls_lisa_mueller-employee_uuid.
    ls_req-details = 'Sommerurlaub'.
    ls_req-status = 'G'.
    GET TIME STAMP FIELD ls_req-created_at.
    GET TIME STAMP FIELD ls_req-last_changed_at.
    APPEND ls_req TO lt_req.

    ls_req-client = sy-mandt.
    ls_req-request_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_req-created_by = 'GENERATOR'.
    ls_req-last_changed_by = 'GENERATOR'.
    ls_req-applicant_uuid = ls_hans_maier-employee_uuid.
    ls_req-start_date = '20251227'.
    ls_req-end_date = '20251230'.
    ls_req-leave_days = '3'.
    ls_req-approver_uuid = ls_lisa_mueller-employee_uuid.
    ls_req-details = 'Weihnachtsurlaub'.
    ls_req-status = 'A'.

    GET TIME STAMP FIELD ls_req-created_at.
    GET TIME STAMP FIELD ls_req-last_changed_at.
    APPEND ls_req TO lt_req.

    ls_req-client = sy-mandt.
    ls_req-request_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_req-created_by = 'GENERATOR'.
    ls_req-last_changed_by = 'GENERATOR'.
    ls_req-applicant_uuid = ls_hans_maier-employee_uuid.
    ls_req-start_date = '20251228'.
    ls_req-end_date = '20251230'.
    ls_req-leave_days = '3'.
    ls_req-approver_uuid = ls_lisa_mueller-employee_uuid.
    ls_req-details = 'Weihnachtsurlaub (2. Versuch)'.
    ls_req-status = 'G'.

    GET TIME STAMP FIELD ls_req-created_at.
    GET TIME STAMP FIELD ls_req-last_changed_at.
    APPEND ls_req TO lt_req.

    ls_req-client = sy-mandt.
    ls_req-request_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_req-created_by = 'GENERATOR'.
    ls_req-last_changed_by = 'GENERATOR'.
    ls_req-applicant_uuid = ls_hans_maier-employee_uuid.
    ls_req-start_date = '20260527'.
    ls_req-end_date = '20260614'.
    ls_req-leave_days = '12'.
    ls_req-approver_uuid = ls_lisa_mueller-employee_uuid.
    ls_req-details = ''.
    ls_req-status = 'G'.

    GET TIME STAMP FIELD ls_req-created_at.
    GET TIME STAMP FIELD ls_req-last_changed_at.
    APPEND ls_req TO lt_req.

    ls_req-client = sy-mandt.
    ls_req-request_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_req-created_by = 'GENERATOR'.
    ls_req-last_changed_by = 'GENERATOR'.
    ls_req-applicant_uuid = ls_hans_maier-employee_uuid.
    ls_req-start_date = '20261220'.
    ls_req-end_date = '20261231'.
    ls_req-leave_days = '5'.
    ls_req-approver_uuid = ls_lisa_mueller-employee_uuid.
    ls_req-details = 'Winterurlaub'.
    ls_req-status = 'B'.

    GET TIME STAMP FIELD ls_req-created_at.
    GET TIME STAMP FIELD ls_req-last_changed_at.
    APPEND ls_req TO lt_req.

    ls_req-client = sy-mandt.
    ls_req-request_uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    ls_req-created_by = 'GENERATOR'.
    ls_req-last_changed_by = 'GENERATOR'.
    ls_req-applicant_uuid = ls_petra_schmid-employee_uuid.
    ls_req-start_date = '20261227'.
    ls_req-end_date = '20261231'.
    ls_req-leave_days = '4'.
    ls_req-approver_uuid = ls_hans_maier-employee_uuid.
    ls_req-details = 'Weihnachtsurlaub'.
    ls_req-status = 'B'.

    GET TIME STAMP FIELD ls_req-created_at.
    GET TIME STAMP FIELD ls_req-last_changed_at.
    APPEND ls_req TO lt_req.

    INSERT zlc_employee FROM TABLE @lt_employee.
    out->write( |Inserted Employees: { sy-dbcnt } | ).

    INSERT zlc_ent FROM TABLE @lt_ent.
    out->write( |Inserted Vacation Entitlements: { sy-dbcnt } | ).

    INSERT zlc_req FROM TABLE @lt_req.
    out->write( |Inserted Vacation Requests: { sy-dbcnt } | ).

  ENDMETHOD.

ENDCLASS.
