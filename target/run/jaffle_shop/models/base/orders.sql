

  create or replace view `fishtown-interview-292223`.`dbt_atambay`.`orders`
  OPTIONS()
  as with base as (
    select * from `fa--interview-task.interview.orders`
),

xf as (
    select 
        *,
        case
            when status IN ('paid', 'completed', 'shipped') THEN 'completed' 
            else status 
        end as order_status_category
    from base
)

select * from xf;

