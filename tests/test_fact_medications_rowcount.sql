-- Warn if fact_medications grows too large relative to fact_visits

with visit_counts as (
    select count(*) as num_visits
    from {{ ref('fact_visits') }}
),
med_counts as (
    select count(*) as num_meds
    from {{ ref('fact_medications') }}
)

select
    m.num_meds,
    v.num_visits,
    round(m.num_meds::float / v.num_visits, 2) as meds_per_visit
from med_counts m, visit_counts v
where (m.num_meds::float / nullif(v.num_visits,0)) > 50  -- threshold
