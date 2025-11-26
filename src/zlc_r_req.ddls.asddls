
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'basic view for leave requests'
define view entity ZLC_R_REQ 
as select from zlc_req
association to parent ZLC_R_Employee as _employee      on $projection.ApplicantUuid = _employee.EmployeeUuid
association to zlc_i_employeetext    as _approvertext  on $projection.ApproverUuid = _approvertext.employee_uuid
association to zlc_i_employeetext    as _applicanttext on $projection.ApplicantUuid = _applicanttext.employee_uuid
association to zlc_i_statustext      as _statustext    on $projection.RequestUuid = _statustext.request_uuid
{
    
  key request_uuid  as RequestUuid,
      applicant_uuid         as ApplicantUuid,
      approver_uuid          as ApproverUuid,
      start_date             as StartDate,
      end_date               as EndDate,
      leave_days          as LeaveDays,
      details                as Details,
      status                 as Status,

      /* Administrative Data */
      @Semantics.user.createdBy: true
      created_by             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at             as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by        as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at        as LastChangedAt,

      _employee,
      _approvertext.Name     as ApproverName,
      _applicanttext.Name    as ApplicantName,
      _statustext.StatusText as StatusText

}
