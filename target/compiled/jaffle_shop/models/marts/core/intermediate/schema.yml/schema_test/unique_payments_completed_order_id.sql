
    
    



select count(*) as validation_errors
from (

    select
        order_id

    from `fishtown-interview-292223`.`dbt_atambay`.`payments_completed`
    where order_id is not null
    group by order_id
    having count(*) > 1

) validation_errors


