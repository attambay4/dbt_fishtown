with source as (

    select * from `fishtown-interview-292223`.`dbt_atambay`.`stg_devices`
),

--determining first device used for purchase
xf as (

    select distinct
                    cast(type_id as int64) as order_id,
                    first_value(device) OVER (partition by type_id order by
                      created_at ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED
                      FOLLOWING) as purchase_device

    from source
    where type = 'order'
),

--determining categories for the purchase device derived above
categories as (

    select
        *,
        CASE
            WHEN purchase_device = 'web' THEN 'desktop'
            WHEN purchase_device IN ('ios-app', 'android-app') THEN 'mobile-app'
            when purchase_device IN ('mobile', 'tablet') THEN 'mobile-web'
            when NULLIF(purchase_device, '') IS NULL THEN 'unknown'
            ELSE 'ERROR'
        END AS purchase_device_type
        
    from xf
)

select * from categories