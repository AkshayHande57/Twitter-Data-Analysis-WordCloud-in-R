-- dtm _trades table 
select dtr_dt, dtr_trd_no,DTR_ENT_ID
from dtm_trades_All_records
where cast(dtr_dt as date) = '2017-04-03'
-- 14478 records 

-- Contract_note_Master records 
select (DCD_DT), DCD_TRADE_NO,DCD_ENT_ID,DCD_PURE_BRK
from dtm_contract_note_details_All_records
where cast(dcd_dt as date) = '2017-04-03'
-- 14506 records

-- 28 records more in dtm_contract_note_details table 

-- Joining this tables 
-- Full Outer Join 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a full outer join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14564 records

-- On full outer join : 86 rows more as compare to trades tbl.
-- left join 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a left join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14564 

-- inner Join 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a inner join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO
-- 14564 rows

-- outer join 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a full outer join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO

-- dtr_Customer_broker_table
select a.DTR_DT , a.DTR_TRD_NO , b.DCD_TRADE_NO ,a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK 
into Trans_brokerage
from dtm_trades_All_records a full outer join dtm_contract_note_details_All_records b 
on a.DTR_TRD_NO = b.DCD_TRADE_NO where cast(a.dtr_dt as date) = '2017-04-03'
-- 14564 rows retrived 

-- Trans_brokerage 
select * from Trans_brokerage
-- 14564 records present 

select tb.DTR_ENT_ID ,count(*)
from Trans_brokerage tb 
group by DTR_ENT_ID
-- 3024 unique customer has performed transaction 

select distinct(tb.DTR_TRD_NO)
from Trans_brokerage tb 
-- 14449 rows 

select tb.dtr_trd_no , count(*)
from Trans_brokerage  tb 
group by tb.DTR_TRD_NO 
-- 14449 records 

select tb.DTR_TRD_NO, tb.DCD_PURE_BRK
from Trans_brokerage tb 
-- 14506 records 

select *
from Trans_brokerage tb
where tb.DCD_PURE_BRK = 0.0

select c.DCD_PURE_BRK,count(*)
from dtm_contract_note_details_All_records c
where c.DCD_DT = '2017-04-03'
group by c.DCD_PURE_BRK

select * 
from dtm_contract_note_details_All_records c 
where c.DCD_PURE_BRK = 0.0
and c.DCD_DT = '2017-04-03'


