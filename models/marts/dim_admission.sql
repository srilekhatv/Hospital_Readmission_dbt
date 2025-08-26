{{ config(materialized='table') }}

with admission_types as (

    select 1 as admission_type_id, 'Emergency' as admission_type
    union all select 2, 'Urgent'
    union all select 3, 'Elective'
    union all select 4, 'Newborn'
    union all select 5, 'Not Available'
    union all select 6, 'NULL'
    union all select 7, 'Trauma Center'
    union all select 8, 'Not Mapped'

)

select * from admission_types
