{{
    config(
        materialized = 'table',
        dist = 'payment_id',
        sort = 'created_at'
    )
}}

with source as (
    
    select * from `fa--interview-task.interview.payments`
)

select * from source