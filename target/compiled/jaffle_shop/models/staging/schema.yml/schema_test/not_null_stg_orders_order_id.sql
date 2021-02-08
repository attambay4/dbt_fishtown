
    
    



select count(*) as validation_errors
from `fishtown-interview-292223`.`dbt_atambay`.`stg_orders`
where order_id is null


