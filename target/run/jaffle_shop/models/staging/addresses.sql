

  create or replace table `fishtown-interview-292223`.`dbt_atambay`.`addresses`
  
  
  OPTIONS()
  as (
    

with source as (
    select * from `fa--interview-task.interview.addresses`
),

--determining country type
xf as (
    select
        *,
        case
            when country_code is null then 'Null country' 
            when country_code = 'US' THEN 'US' 
            else 'International' 
        end as country_type
    from source
)

select * from xf
  );
    