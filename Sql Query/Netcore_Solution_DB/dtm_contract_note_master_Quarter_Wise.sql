-- Extracting  dtm contract note master table in Netcore DB - Quarter Wise 

-- Q1
select * into dtm_contract_note_master_Q1 from OpenQuery(PRCSN,'select * from dtm_contract_note_master 
where dcn_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''30-06-2017'',''dd-mm-yyyy'')')
-- dtm_contract_note_master_Q1 --218105  -- Execution Time : 1.41 mins

-- Q2 
select *  into dtm_contract_note_master_Q2 from OpenQuery(PRCSN,'select * from dtm_contract_note_master 
where dcn_date between To_date(''01-07-2017'',''dd-mm-yyyy'') and To_date(''30-09-2017'',''dd-mm-yyyy'')')
-- dtm_contract_note_master_Q2 -242627  - Execution Time : 1.54 mins

-- Q3 1st Oct 2017 to 31st Dec 2017
select *  into dtm_contract_note_master_Q3 from OpenQuery(PRCSN,'select * from dtm_contract_note_master 
where dcn_date between To_date(''01-10-2017'',''dd-mm-yyyy'') and To_date(''31-12-2017'',''dd-mm-yyyy'')')
-- dtm_contract_note_master_Q3 --249520  --Execution Time :1.56

-- Q4 1st Jan 2018 to 31st March 2018
select *  into dtm_contract_note_master_Q4 from OpenQuery(PRCSN,'select * from dtm_contract_note_master 
where dcn_date between To_date(''01-01-2018'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- dtm_contract_note_master_Q4 --258673  --Execution Time : 2.04

-- Total Number of Rows : Q1 + Q2 + Q3 + Q4 = 968925

-- Appending all records for dtm_contract_note_master_all 

select * into dtm_contract_note_master_All_records
from [dbo].[dtm_contract_note_master_Q1]
UNION 
select * from [dbo].[dtm_contract_note_master_Q2]
UNION
select * from [dbo].[dtm_contract_note_master_Q3]
UNION 
select * from [dbo].[dtm_contract_note_master_Q4]


-- QC Test 
select min(dcn_date),max(dcn_date) 
from dtm_contract_note_master_All_records


-- Top 100 rows 
select top 100 * from dtm_contract_note_master_All_records
