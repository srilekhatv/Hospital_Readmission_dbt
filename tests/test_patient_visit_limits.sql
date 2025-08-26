with counts as (
    select
        patient_nbr,
        count(*) as visit_count
    from {{ ref('stg_patient_visits') }}
    group by patient_nbr
)
select *
from counts
where visit_count > 40
