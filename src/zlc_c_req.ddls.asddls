
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for leave requests'
@Metadata.allowExtensions: true
define view entity zlc_c_req 
as projection on ZLC_R_REQ
{
    key RequestUuid,
    @ObjectModel.text.element: [ 'ApplicantName' ]
    ApplicantUuid,
    @ObjectModel.text.element: [ 'ApproverName' ]
    @UI.textArrangement: #TEXT_ONLY
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZLC_I_ApproverVH', element: 'EmployeeUuid' } }]
    ApproverUuid,
    StartDate,
    EndDate,
    LeaveDays,
    Details,
    @ObjectModel.text.element: [ 'StatusText' ]
    Status,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    ApproverName,
    ApplicantName,
    StatusText,
    /* Associations */
    _employee: redirected to parent ZLC_C_EMPLOYEE
}
