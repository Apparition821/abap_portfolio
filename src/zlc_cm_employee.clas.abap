CLASS zlc_cm_employee DEFINITION
  INHERITING FROM cx_static_check
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    CONSTANTS:
      BEGIN OF invalid_dates,
        msg_id TYPE symsgid VALUE 'ZLC_REQ',
        msgno  TYPE symsgno VALUE '001',
        attr1  TYPE scx_attrname VALUE '',
        attr2  TYPE scx_attrname VALUE '',
        attr3  TYPE scx_attrname VALUE '',
        attr4  TYPE scx_attrname VALUE '',
      END OF invalid_dates.

    CONSTANTS:
      BEGIN OF not_enough_days_left,
        msg_id TYPE symsgid VALUE 'ZLC_REQ',
        msgno  TYPE symsgno VALUE '002',
        attr1  TYPE scx_attrname VALUE 'REMAINING_LEAVE_DAYS',
        attr2  TYPE scx_attrname VALUE 'REQUESTED_LEAVE_DAYS',
        attr3  TYPE scx_attrname VALUE '',
        attr4  TYPE scx_attrname VALUE '',
      END OF not_enough_days_left.

    CONSTANTS:
      BEGIN OF different_years,
        msg_id TYPE symsgid VALUE 'ZLC_REQ',
        msgno  TYPE symsgno VALUE '003',
        attr1  TYPE scx_attrname VALUE '',
        attr2  TYPE scx_attrname VALUE '',
        attr3  TYPE scx_attrname VALUE '',
        attr4  TYPE scx_attrname VALUE '',
      END OF different_years.

     CONSTANTS:
      BEGIN OF already_processed,
        msg_id TYPE symsgid VALUE 'ZLC_REQ',
        msgno  TYPE symsgno VALUE '004',
        attr1  TYPE scx_attrname VALUE '',
        attr2  TYPE scx_attrname VALUE '',
        attr3  TYPE scx_attrname VALUE '',
        attr4  TYPE scx_attrname VALUE '',
      END OF already_processed.

     CONSTANTS:
      BEGIN OF approved,
        msg_id TYPE symsgid VALUE 'ZLC_REQ',
        msgno  TYPE symsgno VALUE '005',
        attr1  TYPE scx_attrname VALUE '',
        attr2  TYPE scx_attrname VALUE '',
        attr3  TYPE scx_attrname VALUE '',
        attr4  TYPE scx_attrname VALUE '',
      END OF approved.

     CONSTANTS:
      BEGIN OF rejected,
        msg_id TYPE symsgid VALUE 'ZLC_REQ',
        msgno  TYPE symsgno VALUE '006',
        attr1  TYPE scx_attrname VALUE '',
        attr2  TYPE scx_attrname VALUE '',
        attr3  TYPE scx_attrname VALUE '',
        attr4  TYPE scx_attrname VALUE '',
      END OF rejected.



    DATA remaining_leave_days TYPE i.
    DATA requested_leave_days TYPE i.

    METHODS constructor
      IMPORTING
        severity                TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid                  LIKE if_t100_message=>t100key DEFAULT if_t100_message=>default_textid
        !previous               LIKE previous OPTIONAL
        remaining_leave_days TYPE i OPTIONAL
        requested_leave_days TYPE i OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zlc_cm_employee IMPLEMENTATION.
METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->remaining_leave_days = remaining_leave_days.
    me->requested_leave_days = requested_leave_days.

  ENDMETHOD.
ENDCLASS.
