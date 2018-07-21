-- dtm _trades table 
select dtr_dt, dtr_trd_no,DTR_ENT_ID
from dtm_trades_All_records
where cast(dtr_dt as date) = '2017-04-03 '
-- 14478 records 

-- Contract_note_Master records 
select (DCD_DT), DCD_TRADE_NO,DCD_ENT_ID,DCD_PURE_BRK
from dtm_contract_note_details_All_records
where cast(dcd_dt as date) = '2017-04-03'
-- 14506 records

-- Differene of 28 records, More 28 transaction records present in contract_note_details table. 

-- Joining this tables 
-- Full Outer Join 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a full outer join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14564 records

-- Left Join on one key only 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a left join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14564 records

-- inner join using multiple keys for joins.
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a inner join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO and 
a.DTR_ORD_NO = b.DCD_ORDER_NO and 
a.DTR_DT = b.DCD_DT and 
a.DTR_ENT_ID = b.DCD_ENT_ID and 
a.DTR_BUY_SELL_FLG = b.DCD_BUY_SELL_FLG and 
a.DTR_DCM_ID = b.DCD_DCM_ID
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14506 records

-- Left join on multiple Keys 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a left join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO and 
a.DTR_ORD_NO = b.DCD_ORDER_NO and 
a.DTR_DT = b.DCD_DT and 
a.DTR_ENT_ID = b.DCD_ENT_ID and 
a.DTR_BUY_SELL_FLG = b.DCD_BUY_SELL_FLG and 
a.DTR_DCM_ID = b.DCD_DCM_ID
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14506 records


-- full outer joins 
select a.DTR_DT , a.DTR_TRD_NO , a.DTR_ENT_ID , b.DCD_ENT_ID , b.DCD_PURE_BRK
from dtm_trades_All_records a full outer join dtm_contract_note_details_All_records b
on a.DTR_TRD_NO = b.DCD_TRADE_NO and 
a.DTR_ORD_NO = b.DCD_ORDER_NO and 
a.DTR_DT = b.DCD_DT and 
a.DTR_ENT_ID = b.DCD_ENT_ID and 
a.DTR_BUY_SELL_FLG = b.DCD_BUY_SELL_FLG and 
a.DTR_DCM_ID = b.DCD_DCM_ID
where cast(a.dtr_dt as date) = '2017-04-03'
-- 14506 records  

