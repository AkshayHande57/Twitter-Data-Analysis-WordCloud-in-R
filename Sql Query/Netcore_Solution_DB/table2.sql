-- Table 2 : 1st June 2017 to 31st Jul 2017
select *  into EQ_Contract_note_details_Table2 from OpenQuery(PRCSN,'select * from contract_note_details 
where cnd_dt between To_date(''01-06-2017'',''dd-mm-yyyy'') and To_date(''31-07-2017'',''dd-mm-yyyy'')')
-- EQ_Contract_note_details_Table2 
-- Execution Time :  
