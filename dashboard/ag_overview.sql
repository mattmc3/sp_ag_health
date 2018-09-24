-- Expore mimicing the AG dashboards in SSMS

-- Availability group overview
drop table if exists #availability_groups
select * into #availability_groups from sys.availability_groups

drop table if exists #availability_replicas
select * into #availability_replicas from sys.availability_replicas

drop table if exists #dm_hadr_availability_group_states
select * into #dm_hadr_availability_group_states from sys.dm_hadr_availability_group_states

select
       case when hags.synchronization_health <> 2 then '!!'
            when hags.primary_recovery_health = 1 then '+'
            when hags.secondary_recovery_health = 1 then ''
            else '~~'
       end as [Indicator]
     , ag.name as [Availability Group Name]
     , hags.primary_replica as [Primary Instance]
     , ar.failover_mode_desc as [Failover Mode]
     , case when hags.synchronization_health <> 2 then 'Not healthy' else '' end as [Issues]
from #availability_groups ag
join #dm_hadr_availability_group_states hags on ag.group_id = hags.group_id
join #availability_replicas ar on ag.group_id = ar.group_id
                                 and ar.replica_metadata_id is not null
order by ag.name
