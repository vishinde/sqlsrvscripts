--https://mattsql.wordpress.com/2012/03/21/querying-sql-server-maintenance-plans/

select 
	p.name as 'Maintenance Plan'
	,p.[description] as 'Description'
	,p.[owner] as 'Plan Owner'
	,sp.subplan_name as 'Subplan Name'
	,sp.subplan_description as 'Subplan Description'
	,j.name as 'Job Name'
	,j.[description] as 'Job Description'  
from msdb..sysmaintplan_plans p
	inner join msdb..sysmaintplan_subplans sp
	on p.id = sp.plan_id
	inner join msdb..sysjobs j
	on sp.job_id = j.job_id
where j.[enabled] = 1