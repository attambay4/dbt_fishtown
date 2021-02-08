{{
    config(
        materialized = 'table',
        dist = 'user_id',
        sort = 'order_id'
    )
}}

with source as (

    select * from {{ source('data', 'addresses') }}
),

--determining country type
xf as (

    select
        *,
        case
            when country_code is null then 'Null country'
            when country_code = 'US' THEN 'US'
            else 'International'
        end as country_type

    from source
)

select * from xf
