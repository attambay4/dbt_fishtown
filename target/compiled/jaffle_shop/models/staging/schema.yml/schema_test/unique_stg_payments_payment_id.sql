
    
    



select count(*) as validation_errors
from (

    select
        payment_id

    from `fishtown-interview-292223`.`dbt_atambay`.`stg_payments`
    where payment_id is not null
    group by payment_id
    having count(*) > 1

) validation_errors


