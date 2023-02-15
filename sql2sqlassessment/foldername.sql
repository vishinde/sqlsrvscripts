SELECT CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(15)) AS Version, 
@@SERVERNAME as machinename, 
'master'as databasename, 
@@ServiceName as instancename, 
FORMAT(GETDATE() , 'MMddyyHHmmss') as current_ts
