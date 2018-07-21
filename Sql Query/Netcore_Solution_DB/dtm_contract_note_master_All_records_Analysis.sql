-- Analysing dtm_contract_note_master_All_records of table 
select top 100 * from dtm_contract_note_master_All_records

select distinct(dcn_stage),count(*) 
from dtm_contract_note_master_All_records
group by dcn_stage
/*
dcn_stage	(No column name)
A	8288
C	7933
F	952704
*/

select distinct(dcn_generated_flg),count(*) 
from dtm_contract_note_master_All_records
group by dcn_generated_flg


select distinct(dcn_other_fee),count(*) 
from dtm_contract_note_master_All_records
group by dcn_other_fee


select distinct(dcn_prg_id),count(*) 
from dtm_contract_note_master_All_records
group by dcn_prg_id
/*
dcn_prg_id	(No column name)
DTMBDRCN	952704
DTMBSTC	8288
DTMFBL11	7933*/

select distinct(dcn_clearing_amt),count(*) 
from dtm_contract_note_master_All_records
group by dcn_clearing_amt

select distinct(dcn_can_remarks),count(*) 
from dtm_contract_note_master_All_records
group by dcn_can_remarks
/*
dcn_can_remarks	(No column name)
NULL	960992
CANCEL CONTRACT	3605
CANCELL	2
CANCELLED CN	4326
*/







