-- Table 8 : 1st Nov 2017 to 30th Nov 2017 
select *  into EQ_Contract_note_details_Nov from OpenQuery(PRCSN,'select * from contract_note_details
where cnd_dt between To_date(''01-11-2017'',''dd-mm-yyyy'') and To_date(''30-11-2017'',''dd-mm-yyyy'')')
-- EQ_Contract_note_details_Nov
