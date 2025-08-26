{{ config(materialized='table') }}

with diagnosis_categories as (

    select 1 as diagnosis_id, 'Circulatory'    as diagnosis_category
    union all
    select 2, 'Respiratory'
    union all
    select 3, 'Digestive'
    union all
    select 4, 'Diabetes'
    union all
    select 5, 'Injury'
    union all
    select 6, 'Musculoskeletal'
    union all
    select 7, 'Genitourinary'
    union all
    select 8, 'Neoplasms'
    union all
    select 9, 'Other'
    union all
    select 10, 'Unknown'

)

select * from diagnosis_categories
