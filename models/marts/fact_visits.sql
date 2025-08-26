{{ config(
    materialized='incremental',
    unique_key='encounter_id'
) }}

with visits as (
    select
        encounter_id,
        patient_nbr,
        admission_type_id,
        discharge_disposition_id,
        admission_source_id,
        diag_1,
        diag_2,
        diag_3,
        medical_specialty,
        payer_code,
        time_in_hospital,
        num_lab_procedures,
        num_procedures,
        num_medications,
        number_inpatient,
        number_outpatient,
        number_emergency,
        max_glu_serum,
        A1Cresult,
        change_flag,
        diabetesMed,
        readmitted_flag
    from {{ ref('stg_patient_visits') }}
),

-- join patients
with_patient as (
    select
        v.*,
        p.patient_id
    from visits v
    left join {{ ref('dim_patients') }} p
      on v.patient_nbr = p.patient_nbr
),

-- join diagnoses
with_diagnoses as (
    select
        wp.*,
        d1.diagnosis_id as diag1_id,
        d2.diagnosis_id as diag2_id,
        d3.diagnosis_id as diag3_id
    from with_patient wp
    left join {{ ref('dim_diagnosis') }} d1
      on wp.diag_1 = d1.diagnosis_category
    left join {{ ref('dim_diagnosis') }} d2
      on wp.diag_2 = d2.diagnosis_category
    left join {{ ref('dim_diagnosis') }} d3
      on wp.diag_3 = d3.diagnosis_category
),

-- join other dimension references (admission, discharge, source, payer, specialty)
with_refs as (
    select
        wd.*,
        da.admission_type_id        as admission_type_id_ref,
        dd.discharge_disposition_id as discharge_disposition_id_ref,
        das.admission_source_id     as admission_source_id_ref,
        dp.payer_id                 as payer_id,
        ms.specialty_id             as specialty_id
    from with_diagnoses wd
    left join {{ ref('dim_admission') }} da
      on wd.admission_type_id = da.admission_type_id
    left join {{ ref('dim_discharge') }} dd
      on wd.discharge_disposition_id = dd.discharge_disposition_id
    left join {{ ref('dim_admission_source') }} das
      on wd.admission_source_id = das.admission_source_id
    left join {{ ref('dim_payer') }} dp
      on wd.payer_code = dp.payer_code
    left join {{ ref('dim_medical_specialty') }} ms
      on wd.medical_specialty = ms.medical_specialty
)

select
    encounter_id,
    patient_id,
    admission_type_id,
    discharge_disposition_id,
    admission_source_id,
    diag1_id,
    diag2_id,
    diag3_id,
    payer_code,
    medical_specialty,
    time_in_hospital,
    num_lab_procedures,
    num_procedures,
    num_medications,
    number_inpatient,
    number_outpatient,
    number_emergency,
    max_glu_serum,
    A1Cresult,
    change_flag,
    diabetesMed,
    readmitted_flag
from with_refs

{% if is_incremental() %}
  -- only insert rows that are not already in the target
  where encounter_id not in (select encounter_id from {{ this }})
{% endif %}
