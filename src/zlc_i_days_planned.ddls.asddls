@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help for days planned'
define view entity zlc_i_days_planned 
as select from zlc_req
{
    
  key request_uuid       as RequestUuid,
      applicant_uuid              as ApplicantUuid,
      substring(start_date, 1, 4) as RequestYear,
      leave_days               as FilteredDays
}
where
      start_date > $session.system_date
  and status     != 'A'
