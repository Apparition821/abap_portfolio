@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for employee'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity zlc_c_employee
  provider contract transactional_query
  as projection on ZLC_R_EMPLOYEE
{
  key EmployeeUuid,
      EmployeeId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      FirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      LastName,
      EntryDate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangeAt,
      EmployeeName,
      /* Associations */
      _entitlement : redirected to composition child ZLC_C_ENT,
      _request     : redirected to composition child ZLC_C_REQ
}
