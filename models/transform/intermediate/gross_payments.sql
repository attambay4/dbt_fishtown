with payments as (
    select * from {{ref('payments')}}
),

xf as (
    select 
        order_id, 
        sum( 
            CASE 
                WHEN status = 'completed' THEN tax_amount_cents 
                ELSE 0 
            END 
            ) as gross_tax_amount_cents, 

        sum( 
            CASE 
                WHEN status = 'completed' THEN amount_cents 
                ELSE 0 
            END
            ) as gross_amount_cents, 

        sum( 
            CASE 
                WHEN status = 'completed' THEN amount_shipping_cents 
                ELSE 0 
            END 
            ) as gross_shipping_amount_cents,

        sum( 
            CASE 
                WHEN status = 'completed' THEN (tax_amount_cents + amount_cents + amount_shipping_cents)
                ELSE 0 
            END 
            ) as gross_total_amount_cents 
            
    from payments 
    group by order_id 
)

select * from xf