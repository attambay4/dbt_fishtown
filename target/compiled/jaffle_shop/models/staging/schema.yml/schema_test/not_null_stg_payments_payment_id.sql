
    
    



select count(*) as validation_errors
from `fishtown-interview-292223`.`dbt_atambay`.`stg_payments`
where payment_id is null


