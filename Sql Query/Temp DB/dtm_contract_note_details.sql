-- Exploring dtm_Contract_note_details 

-- All records 
select * from dtm_contract_note_details

select distinct(DCD_CHM_ID),count(*) 
from dtm_contract_note_details
group by DCD_CHM_ID

/*
DCD_CHM_ID	(No column name)
DEFAULT	14
ITS	17
OWS	27
TWS	42
*/

select distinct(dcd_dcm_ID), count(*)
from dtm_contract_note_details
group by DCD_DCM_ID


-- Buy & Sell flag count 
select distinct(DCD_BUY_SELL_FLG) ,count(*)
from dtm_contract_note_details
group by DCD_BUY_SELL_FLG
/*
DCD_BUY_SELL_FLG	(No column name)
B	64
S	36
*/


-- DST_TYPE Count 
select Distinct(dcd_dst_type), count(*)
from dtm_contract_note_details 
group by DCD_DST_TYPE
/* 
dcd_dst_type	(No column name)
F	1
G	30
O	32
S	37
*/

