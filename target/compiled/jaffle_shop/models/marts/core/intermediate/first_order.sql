with source as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`stg_orders`
),

--determining the first completed order id for each user
xf as (

    select
        user_id,
        min(order_id) as first_order_id
        
    from source
    where status != 'cancelled'
    group by user_id
)

select * from xf