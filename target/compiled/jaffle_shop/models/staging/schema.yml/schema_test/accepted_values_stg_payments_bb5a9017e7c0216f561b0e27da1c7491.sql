
    
    




with all_values as (

    select distinct
        status as value_field

    from `fishtown-interview-292223`.`dbt_atambay`.`stg_payments`

),

validation_errors as (

    select
        value_field

    from all_values
    where value_field not in (
        'cancelled','completed','paid','pending','shipped'
    )
)

select count(*) as validation_errors
from validation_errors


