{{ config(materialized='table') }}

with specialties as (

    select 1 as specialty_id, 'Internal Medicine' as medical_specialty
    union all select 2,  'Emergency/Trauma'
    union all select 3,  'Family/General Practice'
    union all select 4,  'Cardiology'
    union all select 5,  'Surgery'
    union all select 6,  'Endocrinology'
    union all select 7,  'Oncology'
    union all select 8,  'Psychiatry'
    union all select 9,  'Orthopedics'
    union all select 10, 'Pediatrics'
    union all select 11, 'Neurology'
    union all select 12, 'Obstetrics/Gynecology'
    union all select 13, 'Radiology'
    union all select 14, 'Gastroenterology'
    union all select 15, 'Pulmonology'
    union all select 16, 'Other'
    union all select 17, 'Unknown'
    union all select 18, 'Nephrology'

)

select * from specialties
