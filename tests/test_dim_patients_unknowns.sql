-- Fail if more than 5% of patients have Unknown values

with total as (
    select count(*) as total_patients
    from {{ ref('dim_patients') }}
),
unknowns as (
    select count(*) as unknown_count
    from {{ ref('dim_patients') }}
    where race      = 'Unknown'
       or gender    = 'Unknown'
       or age_group = 'Unknown'
)
select
    u.unknown_count,
    t.total_patients,
    round(u.unknown_count::float / t.total_patients * 100, 2) as percent_unknowns
from unknowns u, total t
where (u.unknown_count::float / t.total_patients) > 0.05   -- threshold
