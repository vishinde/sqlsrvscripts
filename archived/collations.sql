--collation settings of databases
SELECT name, collation_name FROM sys.databases;  

--collation settings of tables and columns
SELECT t.name TableName, c.name ColumnName, collation_name  
FROM sys.columns c  
inner join sys.tables t on c.object_id = t.object_id;