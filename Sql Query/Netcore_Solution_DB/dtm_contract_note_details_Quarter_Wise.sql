-- Extracting data from dtm_contract_note_details Quarter Wise.


-- Q1 1st April 2017 to 30th May 2017
select * into dtm_contract_note_details_Q1 from OpenQuery(PRCSN,'select * from dtm_contract_note_details
where dcd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''30-06-2017'',''dd-mm-yyyy'')')
-- dtm_contract_note_details_Q1 - 1287969  - Execution Time : 26.46 mins 

-- Q2 1st June to 30th Sept 2017
select *  into dtm_contract_note_details_Q2 from OpenQuery(PRCSN,'select * from dtm_contract_note_details
where dcd_dt between To_date(''01-07-2017'',''dd-mm-yyyy'') and To_date(''30-09-2017'',''dd-mm-yyyy'')')
-- dtm_contract_note_details_Q2 - 1473308  - Execution Time : 32.29 mins  

-- Q3 1st Oct 2017 to 31st Dec 2017
select *  into dtm_contract_note_details_Q3 from OpenQuery(PRCSN,'select * from dtm_contract_note_details
where dcd_dt between To_date(''01-10-2017'',''dd-mm-yyyy'') and To_date(''31-12-2017'',''dd-mm-yyyy'')')
-- dtm_contract_note_details_Q3 --1450061  --Execution Time : 26.16 mins  

-- Q4 1st Jan 2018 to 31st March 2018
select *  into dtm_contract_note_details_Q4 from OpenQuery(PRCSN,'select * from dtm_contract_note_details
where dcd_dt between To_date(''01-01-2018'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- dtm_contract_note_details_Q4 --1698281   --Execution Time : 32 mins  

-- Total Number of records =  Q1 + Q2 + Q3 + Q4 =  5909619

-- Combining all above records into dtm_contract_note_details_All_records
select * into dtm_contract_note_details_All_records
from [dbo].[dtm_contract_note_details_Q1]
UNION 
select * from [dbo].[dtm_contract_note_details_Q2]
UNION
select * from [dbo].[dtm_contract_note_details_Q3]
UNION 
select * from [dbo].[dtm_contract_note_details_Q4]

-- (5909619 row(s) affected) Execution Time : 06.46

-- QC test 
select min(dcd_dt),max(dcd_dt) from dtm_contract_note_details_All_records