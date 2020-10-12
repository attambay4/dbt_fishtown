

  create or replace view `fishtown-interview-292223`.`dbt_atambay`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `fishtown-interview-292223`.`dbt_atambay`.`my_first_dbt_model`
where id = 1;

