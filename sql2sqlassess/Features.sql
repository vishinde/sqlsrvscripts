--Log shipping
use master;
DECLARE @lsdbs TABLE(a char(100),b char(100),c char(100),d char(100), e char(100), f char(100), g char(100), h char(100), i char(100), j char(100), k char(100), l char(100), m char(100), n char(100), o char(100));
insert INTO @lsdbs 
EXEC sp_help_log_shipping_monitor; 
select count(*) LogShipDBs from @lsdbs;

--DB Mail
SELECT value_in_use DBMailEnabled FROM  sys.configurations WHERE name = 'Database Mail XPs';

--Policy based management
USE msdb;
SELECT count(*) PoliciesEnabled FROM syspolicy_policies where is_enabled =1 ;

--external scripts enabled
Declare @extscript Table (a char(50), b int, c int, d int, e int )
insert  into @extscript exec sp_configure; 
select e ExtScriptsEnabled  
from @extscript where a='external scripts enabled';

--Resource Governor
select count(*) ResGovGroups FROM sys.resource_governor_workload_groups where group_id > 2;

--Server level triggers
select count(*) ServTriggers from sys.server_triggers;

--Service Broker tasks
select count(*) ServBrokerTasks from sys.dm_broker_activated_tasks;

--Endpoints
SELECT count (*) Endpoints FROM sys.endpoints where state = 0 and endpoint_id > 5;

--External Assemblies
select COUNT(*) ExtAccAsmblyEnabled from sys.server_permissions where permission_name = 'External access assembly' and state='G';
