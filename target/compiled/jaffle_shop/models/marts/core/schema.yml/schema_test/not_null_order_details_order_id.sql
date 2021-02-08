
    
    



select count(*) as validation_errors
from `fishtown-interview-292223`.`dbt_atambay`.`order_details`
where order_id is null


