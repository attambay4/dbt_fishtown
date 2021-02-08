

  create or replace table `fishtown-interview-292223`.`dbt_atambay`.`order_details`
  
  
  OPTIONS()
  as (
    

with orders as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`stg_orders`
),

first_order_device as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`first_order_device`
),

first_order as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`first_order`
),

addresses as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`stg_addresses`
),

gross_payments as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`payments_completed`
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
        first_order_device.purchase_device,
        first_order.first_order_id,
        orders.amount_total_cents,
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

--determining 1. if the order is first time (new) or repeated
--determining 2. total payments for within US and outside shipping
categories as (

    select *,
           case
                when first_order_id = order_id THEN 'new'
                else 'repeat'
           end as user_type,
           case
                when currency = 'USD' then amount_total_cents
                else gross_total_amount_cents
           end as total_amount_cents

    from joined
),

--determining amounts in USD
final as (

    select
        *,
        trunc((amount_total_cents / 100),2) as order_amount_total,
        trunc((total_amount_cents/ 100),2) as total_amount,
        trunc((gross_tax_amount_cents/ 100),2) as gross_tax_amount,
        trunc((gross_amount_cents/ 100),2) as gross_amount,
        trunc((gross_shipping_amount_cents/ 100),2) as gross_shipping_amount,
        trunc((gross_total_amount_cents/ 100),2) as gross_total_amount
        
    from categories
)

select * from final
  );
    