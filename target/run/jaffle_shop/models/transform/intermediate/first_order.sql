

  create or replace view `fishtown-interview-292223`.`dbt_atambay`.`first_order`
  OPTIONS()
  as with source as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`orders`
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

select * from xf;

