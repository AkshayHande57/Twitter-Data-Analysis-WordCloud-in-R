-- Union of EQ_contract_note_details
checkpoint

-- Creating new table for EQ_contract_note_details table by using union command.
-- EQ_contract_note_details_All_records contains data from 1st April 2017 to 31st March 2018.

select * into EQ_contract_note_details_All_records
from EQ_Contract_note_details_April 
union 
select * from EQ_Contract_note_details_May
union 
select * from [dbo].[EQ_Contract_note_details_June]
union 
select * from [dbo].[EQ_Contract_note_details_July]
union 
select * from [dbo].[EQ_Contract_note_details_August]
union 
select * from [dbo].[EQ_Contract_note_details_sept]
union 
select * from [dbo].[EQ_Contract_note_details_Oct]
union 
select * from [dbo].[EQ_Contract_note_details_Nov]
union
select * from [dbo].[EQ_Contract_note_details_Dec]
union 
select * from [dbo].[EQ_Contract_note_details_Jan]
union 
select * from [dbo].[EQ_Contract_note_details_Feb]
union 
select * from [dbo].[EQ_Contract_note_details_Mar]