@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'text element for days planned'
define view entity zlc_i_days_plannedtext 
as select from zlc_ent
association to zlc_i_days_planned as _planneddays on $projection.EmployeeUuid = _planneddays.ApplicantUuid
{
    
  key entitlement_uuid        as EntitlementUuid,
      employee_uuid                    as EmployeeUuid,
      sum( _planneddays.FilteredDays ) as PlannedDays
      
}
where
  _planneddays.RequestYear = current_year
group by
  entitlement_uuid,
  employee_uuid
