

  create or replace table `fishtown-interview-292223`.`dbt_atambay`.`stg_payments`
  
  
  OPTIONS()
  as (
    

with source as (

    select * from `fa--interview-task`.`interview`.`payments`    
)

select * from source
  );
    