with source as (
    select * from {{ref('orders')}}
),

--determining the first completed order id
xf as (
    select 
        user_id, 
        min(order_id) as first_order_id 
    from source
    where status != 'cancelled' 
    group by user_id
)

select * from xf