{{ config(
    materialized='table',
    schema='STAGING'
) }}


select
    cast(encounter_id as number(38,0)) as encounter_id,
    cast(patient_nbr as number(38,0)) as patient_nbr,
    race,
    gender,
    age,
    admission_type_id,
    discharge_disposition_id,
    admission_source_id,
    cast(time_in_hospital as number(38,0)) as time_in_hospital,
    payer_code,
    medical_specialty,
    cast(num_lab_procedures as number(38,0)) as num_lab_procedures,
    cast(num_procedures as number(38,0)) as num_procedures,
    cast(num_medications as number(38,0)) as num_medications,
    cast(number_outpatient as number(38,0)) as number_outpatient,
    cast(number_emergency as number(38,0)) as number_emergency,
    cast(number_inpatient as number(38,0)) as number_inpatient,
    diag_1,
    diag_2,
    diag_3,
    cast(number_diagnoses as number(38,0)) as number_diagnoses,
    max_glu_serum,
    A1Cresult,
    -- single meds
    metformin,
    repaglinide,
    nateglinide,
    chlorpropamide,
    glimepiride,
    acetohexamide,
    glipizide,
    glyburide,
    tolbutamide,
    pioglitazone,
    rosiglitazone,
    acarbose,
    miglitol,
    troglitazone,
    tolazamide,
    examide,
    citoglipton,
    insulin,

    -- 👇 combo meds: quote RAW names with hyphens, alias to underscores
    "glyburide-metformin"      as glyburide_metformin,
    "glipizide-metformin"      as glipizide_metformin,
    "glimepiride-pioglitazone" as glimepiride_pioglitazone,
    "metformin-rosiglitazone"  as metformin_rosiglitazone,
    "metformin-pioglitazone"   as metformin_pioglitazone,

    "change"      as change_flag,
    diabetesMed,
    cast(readmitted_flag as number(1,0)) as readmitted_flag
from HOSPITAL_DB.RAW.PATIENT_VISITS
