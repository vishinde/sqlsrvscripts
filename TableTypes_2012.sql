select schema_name(schema_id) as schema_name,
       name as table_name,
        case when is_filetable = 1 then 'File table'
            else 'User Table'
        end as table_type
        from sys.tables
UNION
select schema_name(schema_id) as schema_name,
	t.name as table_name,
	'Partitioned Table' as table_type
from sys.partitions p
inner join sys.tables t
on p.object_id = t.object_id
where p.partition_number <> 1
order by schema_name, table_name;
