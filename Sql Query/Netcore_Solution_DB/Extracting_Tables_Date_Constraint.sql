-- Extracting data for below tables for specified given date range ( 1st April 2017 to 31st March 2018 )

------- Equity Related Tables -------

-- Extracting Data from Trades table to Netcore_solution_DB
select * into EQ_Trades from OpenQuery(PRCSN,'select * from Trades
where TRD_DT between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Extracting Data from contract_note_master table to Netcore_solution_DB 
select *  into EQ_Contract_note_master from OpenQuery(PRCSN,'select * from contract_note_master 
where cnm_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Extracting Data from contract_note_details table to Netcore_solution_DB
select *  into EQ_Contract_note_details from OpenQuery(PRCSN,'select * from contract_note_details 
where cnd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

------- Derivaties Related Tables ------- All Extraction Done -----

-- Extracting Data from dtm_trades table to Netcore_solution_DB 
select * into dtm_trades from OpenQuery(PRCSN,'select * from dtm_trades
where DTR_DT between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Extracting Data from dtm_contract_note_master table to Netcore_solution_DB
select *  into dtm_contract_note_master from OpenQuery(PRCSN,'select * from dtm_contract_note_master
where dcn_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Extracting Data from dtm_contract_note_details table to Netcore_solution_DB 
select * into dtm_contract_note_details from OpenQuery(PRCSN,'select * from dtm_contract_note_details
where dcd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

------- Currency Related Tables ------- All Extraction Done -----

-- Extracting Data from cur_trades table to Netcore_solution_DB 
select  * into cur_trades from OpenQuery(PRCSN,'select * from cur_trades
where DTR_DT between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Extracting Data from cur_contract_note_master table to Netcore_solution_DB
select * into cur_contract_note_master from OpenQuery(PRCSN,'Select * from cur_contract_note_master
where dcn_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- Extracting Data from cur_contract_note_details table to Netcore_solution_DB
select * into cur_contract_note_details from OpenQuery(PRCSN,'select * from cur_contract_note_details
where dcd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

----------------------------------------------------------------------------------------------------------------

-- Extracting data from mfss_trades table 
select top 100 * into mfss_trades from OpenQuery(PRCSN,'select * from mfss_trades')
select * from mfss_trades
where dcd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')