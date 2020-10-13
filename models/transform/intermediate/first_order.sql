with orders as (
    select * from {{ref('orders')}}
),

xf as (
    select 
        user_id, 
        min(order_id) as first_order_id 
    from orders
    where status != 'cancelled' 
    group by user_id
)

select * from xf