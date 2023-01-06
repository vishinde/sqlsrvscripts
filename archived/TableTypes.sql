
select Distinct type_desc
from sys.tables

--SQL Server 2016 onwards
select schema_name(schema_id) as schema_name,
       name as table_name,
        case when is_external = 1 then 'Polybase External table'
            when temporal_type = 2 then 'System versioned table'
            when temporal_type = 1 then 'History table'
            when is_filetable = 1 then 'File table'
            else 'User Table'
        end as table_type
        from sys.tables
order by schema_name, table_name

select object_schema_name(i.object_id) as [schema],
    object_name(i.object_id) as [object],
    i.name as [index],
    s.name as [partition_scheme]
    from sys.indexes i
    join sys.partition_schemes s on i.data_space_id = s.data_space_id

select distinct t.name
from sys.partitions p
inner join sys.tables t
on p.object_id = t.object_id
where p.partition_number <> 1

select count(t.name) as num_partitioned_tables
from sys.partitions p
inner join sys.tables t
on p.object_id = t.object_id
where p.partition_number <> 1

--in-memory tables
SELECT count(name) as cnt_mem_tables
FROM sys.tables
where is_memory_optimized <> 0

--global temp tables
SELECT * FROM tempdb.sys.tables
WHERE name LIKE '##%'
