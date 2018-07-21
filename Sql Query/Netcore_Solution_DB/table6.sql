-- table 6 :  1st Feb 2018 to 31st march 2018
select *  into EQ_Contract_note_details_Table6 from OpenQuery(PRCSN,'select * from contract_note_details 
where cnd_dt between To_date(''01-12-2017'',''dd-mm-yyyy'') and To_date(''31-01-2018'',''dd-mm-yyyy'')')
-- EQ_Contract_note_details_Q4 --  --Execution Time :  
