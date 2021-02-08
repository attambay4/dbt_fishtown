
    
    



select count(*) as validation_errors
from (

    select
        user_id

    from `fishtown-interview-292223`.`dbt_atambay`.`first_order`
    where user_id is not null
    group by user_id
    having count(*) > 1

) validation_errors


