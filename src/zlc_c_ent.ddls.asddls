
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for leave entitlement'
@Metadata.allowExtensions: true
define view ENTITY zlc_c_ent 
as PROJECTION on ZLC_R_ENT
{
    key EntitlementUuid,
    EmployeeUuid,
    CurrentYear,
    AnnualLeave,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    PlannedDays,
    RemainingDays,
    UsedDays,
    /* Associations */
    _employee: redirected to parent ZLC_C_EMPLOYEE
}
