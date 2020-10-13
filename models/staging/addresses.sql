with base as (
    select * from `fa--interview-task.interview.addresses`
),

xf as (
    select
        *,
        case
            when country_code is null then 'Null country' 
            when country_code = 'US' THEN 'US' 
            else 'International' 
        end as country_type
    from base
)

select * from xf