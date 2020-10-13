

  create or replace view `fishtown-interview-292223`.`dbt_atambay`.`first_order_device`
  OPTIONS()
  as with devices as (
    select * from `fishtown-interview-292223`.`dbt_atambay`.`devices`
),

xf as (
    select 
        distinct cast(type_id as int64) as order_id, 
                 first_value(device) OVER (partition by type_id order by created_at 
                                           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
                                          ) as device 
    from devices 
    where type = 'order'
),

categories as (
    select 
        *,
        CASE 
            WHEN device = 'web' THEN 'desktop' 
            WHEN device IN ('ios-app', 'android-app') THEN 'mobile-app' 
            when device IN ('mobile', 'tablet') THEN 'mobile-web' 
            when NULLIF(device, '') IS NULL THEN 'unknown' 
            ELSE 'ERROR' 
        END AS purchase_device_type
    from xf
)

select * from categories;

