{{ config(materialized='table') }}

with admission_sources as (

    select 1  as admission_source_id, 'Physician Referral' as admission_source
    union all select 2,  'Clinic Referral'
    union all select 3,  'HMO Referral'
    union all select 4,  'Emergency Room'
    union all select 5,  'Transfer from Hospital'
    union all select 6,  'Transfer from Skilled Nursing Facility'
    union all select 7,  'Emergency Medical Services'
    union all select 8,  'Court/Law Enforcement'
    union all select 9,  'Information Not Available'
    union all select 10, 'Transfer from Critical Access Hospital'
    union all select 11, 'Normal Delivery'
    union all select 12, 'Premature Birth'
    union all select 13, 'Sick Baby'
    union all select 14, 'Extramural Birth'
    union all select 15, 'Not Available'
    union all select 16, 'Transfer from Other Healthcare Facility'
    union all select 17, 'Born Outside Hospital'
    union all select 18, 'Transfer from Ambulatory Surgery Center'
    union all select 19, 'Transfer from Hospice'
    union all select 20, 'Unknown/Invalid'
    union all select 21, 'Not Mapped'

)

select * from admission_sources
