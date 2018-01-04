# Important-Notes

To find Table/DB Size

select * from all_tables;

select  owner, table_name, num_rows, round((num_rows*avg_row_len)/(1024*1024)) MB 
from all_tables 
where owner not like 'SYS%'  -- Exclude system tables.
and num_rows > 0  -- Ignore empty Tables.
--and tablespace_name='RCAST_GSST_P'  -- Use if table space is known
order by MB desc -- Biggest first.
;


select a.tablespace_name,
(select sum(b.bytes)/1024/1024/1024 from dba_data_files b where a.tablespace_name=b.tablespace_name) as GB_TOT,
(select sum(c.bytes)/1024/1024/1024 from dba_free_space c where a.tablespace_name=c.tablespace_name) as GB_AVAIL,
100*(select sum(c.bytes) from dba_free_space c where a.tablespace_name=c.tablespace_name)/(select sum(b.bytes) from dba_data_files b where a.tablespace_name=b.tablespace_name) as PERC_FREE
from dba_tablespaces a where tablespace_name='RCAST_GSST_P';


