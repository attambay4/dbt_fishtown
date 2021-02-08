{{
    config(
        materialized = 'table',
        dist = 'payment_id',
        sort = 'created_at'
    )
}}

with source as (

    select * from {{ source('data', 'payments') }}    
)

select * from source
