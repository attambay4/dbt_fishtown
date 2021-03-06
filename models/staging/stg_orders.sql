{{
    config(
        materialized = 'table',
        dist = 'user_id',
        sort = 'created_at'
    )
}}

with source as (

    select * from {{ source('data', 'orders') }}
),

--determinining categories for different order statuses
xf as (

    select
        *,
        case
            when status IN ('paid', 'completed', 'shipped') THEN 'completed'
            else status
        end as order_status_category

    from source
)

select * from xf
