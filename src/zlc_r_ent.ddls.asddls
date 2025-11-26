@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'basic view for leave entitlement'
define view entity ZLC_R_ENT 
as select from zlc_ent
association to parent ZlC_R_EMPLOYEE as _employee    on $projection.EmployeeUuid = _employee.EmployeeUuid
association to ZLC_I_Days_takenText    as _useddays   on $projection.EntitlementUuid = _useddays.EntitlementUuid 
association to ZLC_I_Days_plannedText as _planneddays on $projection.EntitlementUuid = _planneddays.EntitlementUuid
{
    
  key entitlement_uuid                                                                       as EntitlementUuid,
      employee_uuid                                                                          as EmployeeUuid,
      current_year                                                                           as CurrentYear,
      annual_leave                                                                           as AnnualLeave,

      /* Administrative Data */
      @Semantics.user.createdBy: true
      created_by                                                                             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                                                             as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                                                                        as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                                                        as LastChangedAt,

      _employee,

      _useddays.UsedDays                                                                     as UsedDays,
      _planneddays.PlannedDays                                                               as PlannedDays,

      annual_leave - coalesce(_useddays.UsedDays, 0) - coalesce(_planneddays.PlannedDays, 0) as RemainingDays
}
