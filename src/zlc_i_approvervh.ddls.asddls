@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help for approver'
define view entity zlc_i_approvervh 
as select from zlc_employee
{
     @UI.hidden: true
  key employee_uuid as EmployeeUuid,
      employee_id   as EmployeeId,
      first_name    as FirstName,
      last_name     as LastName,
      entry_date    as EntryDate
}
