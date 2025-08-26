{{ config(materialized='table') }}

with payers as (

    select 1 as payer_id, 'MC'  as payer_code, 'Medicare' as payer_name
    union all select 2,  'MD', 'Medicaid'
    union all select 3,  'BC', 'Blue Cross'
    union all select 4,  'HM', 'HMO'
    union all select 5,  'SP', 'Self-Pay'
    union all select 6,  'CH', 'ChampUS'
    union all select 7,  'PO', 'POS'
    union all select 8,  'SI', 'Commercial Insurance'
    union all select 9,  'UN', 'Unknown'
    union all select 10, 'OG', 'Other Government'
    union all select 11, 'WC', 'Workers Comp'
    union all select 12, 'OT', 'Other'
    union all select 13, 'NC', 'Not Covered'

)

select * from payers
