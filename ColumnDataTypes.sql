--from https://dataedo.com/kb/query/sql-server/most-used-data-type-in-the-database
select t.name as data_type,
    count(*) as [columns],
    cast(100.0 * count(*) /
    (select count(*) from sys.tables as tab inner join
        sys.columns as col on tab.object_id = col.object_id)
            as numeric(36, 1)) as percent_columns,
      count(distinct tab.object_id) as [tables],
      cast(100.0 * count(distinct tab.object_id) /
      (select count(*) from sys.tables) as numeric(36, 1)) as percent_tables
  from sys.tables as tab
       inner join sys.columns as col
        on tab.object_id = col.object_id
       left join sys.types as t
        on col.user_type_id = t.user_type_id
group by t.name
order by count(*) desc


select count(object_name(c.object_id)) as table_cnt, count(c.name) as computedcol_cnt
from sys.computed_columns c
join sys.objects o on o.object_id = c.object_id
group by  object_name(c.object_id), c.name;

--detailed computed column query
select schema_name(o.schema_id) as schema_name,
       object_name(c.object_id) as table_name,
       column_id,
       c.name as column_name,
       type_name(user_type_id) as data_type,
       definition
from sys.computed_columns c
join sys.objects o on o.object_id = c.object_id
order by schema_name,
         table_name,
         column_id;


