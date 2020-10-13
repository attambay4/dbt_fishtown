

  create or replace view `fishtown-interview-292223`.`dbt_atambay`.`first_orders`
  OPTIONS()
  as with orders as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`orders`
),

xf as (
    select 
        user_id, 
        min(order_id) as first_order_id 
    from orders
    where status != 'cancelled' 
    group by user_id
)

select * from xf;

