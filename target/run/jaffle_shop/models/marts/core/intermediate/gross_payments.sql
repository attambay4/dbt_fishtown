

  create or replace view `fishtown-interview-292223`.`dbt_atambay`.`gross_payments`
  OPTIONS()
  as with source as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`stg_payments`
),

--determinining total payments for each completed order by different categories (tax, shipping etc)
xf as (

    select
        order_id,
        sum(
            CASE
                WHEN status = 'completed' THEN trunc(tax_amount_cents,2)
                ELSE 0
            END
            ) as gross_tax_amount_cents,

        sum(
            CASE
                WHEN status = 'completed' THEN trunc(amount_cents,2)
                ELSE 0
            END
            ) as gross_amount_cents,

        sum(
            CASE
                WHEN status = 'completed' THEN trunc(amount_shipping_cents,2)
                ELSE 0
            END
            ) as gross_shipping_amount_cents,

        sum(
            CASE
                WHEN status = 'completed' THEN trunc((tax_amount_cents + amount_cents + amount_shipping_cents),2)
                ELSE 0
            END
            ) as gross_total_amount_cents

    from source
    group by order_id
)

select * from xf;

