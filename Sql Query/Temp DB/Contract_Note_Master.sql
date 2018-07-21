-- Working with Contract Note Master 

-- Display all records
select * from Contract_note_master

select distinct(CNM_TRADE_ENT_CTRL_ID),count(*) from Contract_note_master 
group by CNM_TRADE_ENT_CTRL_ID

select distinct(cnm_ent_state) , count(*) 
from Contract_note_master group by CNM_ENT_STATE

