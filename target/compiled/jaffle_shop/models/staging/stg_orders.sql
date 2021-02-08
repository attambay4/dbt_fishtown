

with source as (

    select * from `fa--interview-task`.`interview`.`orders`
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