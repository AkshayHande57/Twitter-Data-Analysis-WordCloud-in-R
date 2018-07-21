-- Table 1 : 1st April 2017 to 31st may 2017
select *  into EQ_Contract_note_details_april from OpenQuery(PRCSN,'select * from contract_note_details
where cnd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''30-04-2017'',''dd-mm-yyyy'')')
-- EQ_Contract_note_details_Table1 -  
-- Execution Time :  mins 

