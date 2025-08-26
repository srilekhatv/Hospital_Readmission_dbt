{{ config(
    materialized='incremental',
    unique_key='encounter_med_key'
) }}

with base as (
    select
        encounter_id,
        array_construct(
            object_construct('medication', 'metformin', 'status', metformin),
            object_construct('medication', 'repaglinide', 'status', repaglinide),
            object_construct('medication', 'nateglinide', 'status', nateglinide),
            object_construct('medication', 'chlorpropamide', 'status', chlorpropamide),
            object_construct('medication', 'glimepiride', 'status', glimepiride),
            object_construct('medication', 'acetohexamide', 'status', acetohexamide),
            object_construct('medication', 'glipizide', 'status', glipizide),
            object_construct('medication', 'glyburide', 'status', glyburide),
            object_construct('medication', 'tolbutamide', 'status', tolbutamide),
            object_construct('medication', 'pioglitazone', 'status', pioglitazone),
            object_construct('medication', 'rosiglitazone', 'status', rosiglitazone),
            object_construct('medication', 'acarbose', 'status', acarbose),
            object_construct('medication', 'miglitol', 'status', miglitol),
            object_construct('medication', 'troglitazone', 'status', troglitazone),
            object_construct('medication', 'tolazamide', 'status', tolazamide),
            object_construct('medication', 'examide', 'status', examide),
            object_construct('medication', 'citoglipton', 'status', citoglipton),
            object_construct('medication', 'insulin', 'status', insulin),
            object_construct('medication', 'glyburide_metformin', 'status', glyburide_metformin),
            object_construct('medication', 'glipizide_metformin', 'status', glipizide_metformin),
            object_construct('medication', 'glimepiride_pioglitazone', 'status', glimepiride_pioglitazone),
            object_construct('medication', 'metformin_rosiglitazone', 'status', metformin_rosiglitazone),
            object_construct('medication', 'metformin_pioglitazone', 'status', metformin_pioglitazone)
        ) as meds
    from {{ ref('stg_patient_visits') }}
)

select
    encounter_id,
    med.value:medication::string as medication,
    med.value:status::string     as status,
    -- synthetic key to avoid ambiguity
    encounter_id || '-' || med.value:medication::string as encounter_med_key
from base,
lateral flatten(input => base.meds) med
