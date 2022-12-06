--To verify how many CPUs your SQL Server can see (cpu_count)
--cpu_count = number of logical cpus on the system.
--physical_memory_in_bytes = total amount of physical memory on the machine. sql server 2008 and 2008R2
--physical_memory_kb = total amount of physical memory on the machine. sql server 2012 onwards
select cpu_count as machine_cpu, physical_memory_kb
from sys.dm_os_sys_info

-- how many cores SQL Server can use (includes hyperthreading)
-- license determines how many cores can be used by SQL Server
select count(*) as cpu_count
from sys.dm_os_schedulers
where status = 'VISIBLE ONLINE' and is_online = 1;

--total amount of physical memory on the machine
select total_physical_memory_kb
from sys.dm_os_sys_memory;

--Max memory configuration on SQL Server
select name, value, value_in_use, description
from sys.configurations
where name = 'max server memory (MB)';
