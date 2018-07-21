--  Table 3 :  1st August 2017 to 30th septmeber 2017
select  *  into EQ_Contract_note_details_Table3 from OpenQuery(PRCSN,'select * from contract_note_details 
where cnd_dt between To_date(''01-08-2017'',''dd-mm-yyyy'') and To_date(''30-09-2017'',''dd-mm-yyyy'')')
-- EQ_Contract_note_details_Q3 
-- Execution Time :  
