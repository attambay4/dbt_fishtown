{{
    config(
        materialized = 'table',
        dist = 'type_id',
        sort = 'created_at'
    )
}}

with source as (

    select * from `fa--interview-task.interview.devices`
),

--changing float data format for dates to date data format
modified as (
    
    select 
        type,
        device,   
        date_add(DATE '1900-01-01', INTERVAL cast(created_at as INT64)-2 DAY) as created_at,
        date_add(DATE '1900-01-01', INTERVAL cast(updated_at as INT64)-2 DAY) as updated_at,
        type_id
    from source
)

select * from modified