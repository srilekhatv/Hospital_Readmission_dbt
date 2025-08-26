{{ config(materialized='table') }}

with discharge_types as (

    select 1  as discharge_disposition_id, 'Discharged to home' as discharge_disposition
    union all select 2,  'Discharged/transferred to another short-term hospital'
    union all select 3,  'Discharged/transferred to SNF (Skilled Nursing Facility)'
    union all select 4,  'Discharged/transferred to ICF (Intermediate Care Facility)'
    union all select 5,  'Discharged/transferred to another type of inpatient care institution'
    union all select 6,  'Discharged/transferred to home with home health service'
    union all select 7,  'Left against medical advice'
    union all select 8,  'Discharged/transferred to home under care of Home IV provider'
    union all select 9,  'Admitted as inpatient to this hospital'
    union all select 10, 'Neonate discharged to another hospital'
    union all select 11, 'Neonate to home under care of organized home health service'
    union all select 12, 'Discharged to home for hospice care'
    union all select 13, 'Discharged to a hospice medical facility'
    union all select 14, 'Discharged/transferred to Federal health care facility'
    union all select 15, 'Discharged/transferred to another type of institution for inpatient care'
    union all select 16, 'Discharged/transferred to psychiatric hospital'
    union all select 17, 'Discharged/transferred to critical access hospital'
    union all select 18, 'Discharged/transferred to rehabilitation facility'
    union all select 19, 'Discharged/transferred to long-term care hospital'
    union all select 20, 'Expired (died)'
    union all select 21, 'Still patient or expected to return for outpatient services'
    union all select 22, 'Discharged/transferred to swing bed facility'
    union all select 23, 'Discharged/transferred to another rehabilitation facility'
    union all select 24, 'Discharged/transferred to another hospice care facility'
    union all select 25, 'Discharged/transferred to a nursing facility with Medicare certification'
    union all select 26, 'Discharged/transferred to a long-term care hospital with Medicare certification'
    union all select 27, 'Discharged/transferred to a psychiatric hospital with Medicare certification'
    union all select 28, 'Discharged/transferred to a Federal hospital with Medicare certification'
    union all select 29, 'Unknown/Invalid'
)

select * from discharge_types
