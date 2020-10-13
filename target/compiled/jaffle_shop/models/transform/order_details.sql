with orders as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`orders`
),

first_order_device as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`first_order_device`
),

first_order as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`first_order`
),

addresses as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`addresses`
),

gross_payments as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`gross_payments`
),

joined as (
    SELECT
        orders.order_id, 
        orders.user_id, 
        orders.created_at, 
        orders.updated_at, 
        orders.shipped_at, 
        orders.currency, 
        orders.status AS order_status,
        orders.order_status_category,
        addresses.country_type,
        orders.shipping_method,
        first_order_device.purchase_device_type,
        first_order_device.device as purchase_device,
        first_order.first_order_id,
        orders.amount_total_cents as order_amount_total_cents,
        gross_payments.gross_tax_amount_cents, 
        gross_payments.gross_amount_cents, 
        gross_payments.gross_shipping_amount_cents,
        gross_payments.gross_total_amount_cents
    from orders 
    left join first_order_device
    using (order_id)
    left join first_order
    using (user_id)
    left join addresses
    using (order_id)
    left join gross_payments
    using (order_id)
),

categories as (
    select *,
           case 
                when first_order_id = order_id THEN 'new' 
                else 'repeat' 
           end as user_type,

    --confused as to why this logic was used       
           case
                when currency = 'USD' then order_amount_total_cents 
                else gross_total_amount_cents 
           end as total_amount_cents
    from joined
),

final as (
    select 
        *,
        (order_amount_total_cents / 100) as order_amount_total,
        (total_amount_cents/ 100) as total_amount, 
        (gross_tax_amount_cents/ 100) as gross_tax_amount, 
        (gross_amount_cents/ 100) as gross_amount, 
        (gross_shipping_amount_cents/ 100) as gross_shipping_amount,
        (gross_total_amount_cents/ 100) as gross_total_amount
    from categories 
)

select * from final