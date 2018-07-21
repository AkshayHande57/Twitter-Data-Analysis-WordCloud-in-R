select [SEM_SMST_SECURITY_ID]
      ,[SEM_EXM_EXCH_ID]
      ,[SEM_EXCH_SECURITY_ID]
      ,[SEM_STATUS]
      ,[SEM_DEMAT_FLG]
into stock_code_master 
from 
OpenQuery(PRCSN,'select * from security_exch_map')
-- 88307 rows Execution Time : 0.03 sec


select * from stock_code_master

-- Basic analysis on stock_code_master table.
select distinct(sem_status),count(*) 
from stock_code_master
group by sem_status

/*
sem_status	(No column name)
A	84052
S	4255
*/
-- Demat Flag 
select distinct(sem_demat_flg),count(*) 
from stock_code_master
group by sem_demat_flg
/*
sem_demat_flg	(No column name)
Y	30742
NULL	7
N	57558
*/


-- Exm_exch_ID count 
select distinct(sem_exm_exch_id),count(*)
from stock_code_master
group by sem_exm_exch_id
/*
sem_exm_exch_id	(No column name)
NSE	71304
BSE	17003
*/  

-------------------------------------------------------------------------

select * 
into 
from 
OpenQuery(PRCSN,'select * from security_exch_map')