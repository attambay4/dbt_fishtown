-- analysis/amounts_audit.sql

--based on the raw query, there are 6 different types of amounts getting
--layered in the final result.
--the fields with prefix 'gross_' are understandable
--need to understand what the fields order_amount_total & total_amount represent
--after understanding the two fields, need to make sure we are not
--misrepresenting any data

with source as (

    select  * from {{ref('order_details')}}
),

aggregated as (

    select
        currency,
        sum(order_amount_total) as order_amount_total,
        sum(total_amount) as total_amount,
        sum(gross_tax_amount) as gross_tax_amount,
        sum(gross_amount) as gross_amount,
        sum(gross_shipping_amount) as gross_shipping_amount,
        sum(gross_total_amount) as gross_total_amount
        
    from source
    group by currency
)

select * from aggregated
