{{ config(materialized='table') }}

with ranked as (
    select
        patient_nbr,
        nullif(race, 'Unknown')   as race,
        nullif(gender, 'Unknown') as gender,
        nullif(age, 'Unknown')    as age_group,
        encounter_id,
        row_number() over (
            partition by patient_nbr
            order by encounter_id desc
        ) as rn_latest
    from {{ ref('stg_patient_visits') }}
),

-- keep the latest encounter per patient
latest as (
    select *
    from ranked
    where rn_latest = 1
),

-- latest known race per patient
latest_race as (
    select distinct
        patient_nbr,
        first_value(race ignore nulls) over (
            partition by patient_nbr
            order by encounter_id desc
        ) as known_race
    from ranked
),

-- latest known gender per patient
latest_gender as (
    select distinct
        patient_nbr,
        first_value(gender ignore nulls) over (
            partition by patient_nbr
            order by encounter_id desc
        ) as known_gender
    from ranked
),

-- latest known age per patient
latest_age as (
    select distinct
        patient_nbr,
        first_value(age_group ignore nulls) over (
            partition by patient_nbr
            order by encounter_id desc
        ) as known_age
    from ranked
)

select
    -- surrogate key (ensures uniqueness + not_null)
    row_number() over (order by l.patient_nbr) as patient_id,

    l.patient_nbr,

    coalesce(l.race, lr.known_race, 'Unknown')       as race,
    coalesce(l.gender, lg.known_gender, 'Unknown')   as gender,
    coalesce(l.age_group, la.known_age, 'Unknown')   as age_group

from latest l
left join latest_race   lr on l.patient_nbr = lr.patient_nbr
left join latest_gender lg on l.patient_nbr = lg.patient_nbr
left join latest_age    la on l.patient_nbr = la.patient_nbr
