@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help for days taken'
define view entity zlc_i_days_taken 
as select from zlc_req
{
    
  key request_uuid       as VacationRequestUuid,
      applicant_uuid              as ApplicantUuid,
      substring(start_date, 1, 4) as RequestYear,
      leave_days               as FilteredDays

}
where
      end_date < $session.system_date
  and status   != 'A'
