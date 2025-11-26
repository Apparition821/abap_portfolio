@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'text element for employee'
define view entity zlc_i_employeetext 
as select from zlc_employee
{
    key employee_uuid,
      first_name,
      last_name,

      concat_with_space(first_name, last_name, 1) as Name
}
