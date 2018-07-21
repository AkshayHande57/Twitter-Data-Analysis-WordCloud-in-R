-- Exploring Dtm_contract_note_Master 

-- Display all records 
select * from dtm_contract_note_master

-- Statewise count 
select distinct(DCN_ENT_STATE),count(*) 
from dtm_contract_note_master 
group by DCN_ENT_STATE

-- Total sum of DCN_PURE_BROKERAGE_AMT	DCN_CONTRACT_TRADE_VALUE
select sum(DCN_PURE_BROKERAGE_AMT) as Brokerage_Amount, 
sum(DCN_CONTRACT_TRADE_VALUE) as Contract_Trade_value 
from dtm_contract_note_master
/*
Brokerage_Amount	Contract_Trade_value
138092.1300	71614099.0000
*/

-- Total Difference between DCN_Pure_Brokerage_Amt and Dcn_Brokerage_Amt 
select sum(DCN_PURE_BROKERAGE_AMT) , sum(DCN_BROKERAGE_AMT)
from dtm_contract_note_master




