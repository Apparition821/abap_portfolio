
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'text element for days taken'
define view entity zlc_i_days_takentext 
as select from zlc_ent
association to zlc_i_days_taken as _useddays on $projection.EmployeeUuid = _useddays.ApplicantUuid
{
  key entitlement_uuid     as EntitlementUuid,
      employee_uuid                 as EmployeeUuid,
      sum( _useddays.FilteredDays ) as UsedDays
      
}
where
  _useddays.RequestYear = current_year
group by
  entitlement_uuid,
  employee_uuid
