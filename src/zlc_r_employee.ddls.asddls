
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'basic view for employee'
define root view entity ZLC_R_Employee 
as select from zlc_employee
composition [0..*] of ZLC_R_ENT as _entitlement
composition [0..*] of ZLC_R_REQ as _request
association to zlc_i_employeetext as _employeetext on $projection.EmployeeUuid = _employeetext.employee_uuid
{
    key employee_uuid   as EmployeeUuid,
      employee_id     as EmployeeId,
      first_name      as FirstName,
      last_name       as LastName,
      entry_date      as EntryDate,

      /* Administrative Data */
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_change_at  as LastChangeAt,
      
      _entitlement,
      _request,
      _employeetext.Name as EmployeeName
}
