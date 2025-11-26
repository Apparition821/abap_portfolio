
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'text element for status'
define view entity zlc_i_statustext 
 as select from zlc_req
{
    key request_uuid,
        status,

      case
        when status = 'B' then 'Beantragt'
        when status = 'A' then 'Abgelehnt'
        when status = 'G' then 'Genehmigt'
        else ''
      end as StatusText
    
}
