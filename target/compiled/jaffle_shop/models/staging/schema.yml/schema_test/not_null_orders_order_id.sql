
    
    



select count(*) as validation_errors
from `fishtown-interview-292223`.`dbt_atambay`.`orders`
where order_id is null


