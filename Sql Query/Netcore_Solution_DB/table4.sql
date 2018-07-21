-- Table 4 :  1st October 2017 to 30th Nov 2017
select *  into EQ_Contract_note_details_Table4 from OpenQuery(PRCSN,'select * from contract_note_details 
where cnd_dt between To_date(''01-10-2017'',''dd-mm-yyyy'') and To_date(''30-11-2017'',''dd-mm-yyyy'')')
-- EQ_Contract_note_details_Q4 --  --Execution Time :  
