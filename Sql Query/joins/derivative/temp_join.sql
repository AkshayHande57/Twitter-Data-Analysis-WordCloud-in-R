-- Venn Diagram on dtm_trades & dtm_contract_note_details table.

select a.dtr_trd_no
from dtm_trades_All_records a
-- Number of rows : 6035869 rows 


-- Distinct dtr_trd_no 
select distinct(dtr_trd_no)
from dtm_trades_all_records
-- Number of rows : 6023574


-- dtm_condtract_note_details 
select b.dcd_trade_no
from [dbo].[dtm_contract_note_details_All_records] b
-- 5909619 rows 

-- Distinct Records
select distinct(b.dcd_trade_no)
from [dbo].[dtm_contract_note_details_All_records] b
-- 5822598

-- -- dtm_condtract_note_details 
select b.dcd_trade_no,count(*)
from [dbo].[dtm_contract_note_details_All_records] b
group by b.dcd_trade_no
having count(*) > 1
-- 73418 rows 
