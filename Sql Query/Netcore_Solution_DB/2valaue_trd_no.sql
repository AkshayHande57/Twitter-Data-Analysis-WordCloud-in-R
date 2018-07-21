select *
from dtm_trades_All_records a 
where cast (a.DTR_DT as date)  = '2017-04-03 00:00:00.0000000' 


select * from dtm_contract_note_details_All_records b 
where cast (b.DCD_DT as date)  = '2017-04-03 00:00:00.0000000' 

select  a.DTR_TRD_NO , b.DCD_TRADE_NO,b.DCD_PURE_BRK into all_trd_brk_table
from dtm_trades_All_records a full outer join dtm_contract_note_details_All_records b 
on a.DTR_TRD_NO = b.DCD_TRADE_NO

select * from all_trd_brk_table


select distinct(dtr_trd_no),count(*)
from all_trd_brk_table
group by DTR_TRD_NO


select * 
from all_trd_brk_table
where DTR_TRD_NO = '2017122262611006'

select * 
from dtm_contract_note_details_All_records 
where DCD_TRADE_NO = '2017122262611006'

select DTR_TRD_NO,DCD_TRADE_NO,count(*)
from all_trd_brk_table
group by DTR_TRD_NO,DCD_TRADE_NO

select dcd_trade_no
from all_trd_brk_table
where DCD_TRADE_NO is nUll


-----------------------------------------------------------------------------

select DTR_TRD_NO into t1  -- 14478 records retrived 
from dtm_trades_All_records a 
where cast (a.DTR_DT as date)  = '2017-04-03 00:00:00.0000000' 

select DCD_TRADE_NO into  t2 
from dtm_contract_note_details_All_records b 
where cast (b.DCD_DT as date)  = '2017-04-03 00:00:00.0000000' 

select * from t1 -- 14 478
select * from t2 --14 506 
/*
SELECT column1
FROM table1
INTERSECT
SELECT column1
FROM table2
*/

select dtr_trd_no 
from t1  intersect 
select dcd_trade_no from t2 -- 14449

-- joining t1 & t2  -- 14564 rows retrived 
select * 
from t1 full outer join  t2 
on t1.DTR_TRD_NO = t2.DCD_TRADE_NO


----------------------------------------------------------------------------------
select  * 
from dtm_contract_note_details_All_records a
where a.DCD_TRADE_NO = '2017122262611006'
