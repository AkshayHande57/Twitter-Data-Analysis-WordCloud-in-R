-- Error for where condition, Please check the query for this. 
select top 100 * into Entity_Master from OpenQuery(PRCSN,'select * from entity_master') where cnm_date between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy''))
select * from Entity_Master

-- Creating contract note master table in Netcore DB
select top 100 *  into Contract_note_master from OpenQuery(PRCSN,'select * from contract_note_master where cnm_date between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from Contract_note_master

-- creating contract note details tables in Netcore DB
select top 100 * into Contract_note_details from OpenQuery(PRCSN,'select * from contract_note_details where cnd_dt between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from Contract_note_details


-- Creating dtm contract note master table in Netcore DB 
select top 100 *  into dtm_contract_note_master from OpenQuery(PRCSN,'select * from dtm_contract_note_master where dcn_date between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from dtm_contract_note_master

-- Creating mfss_contract_note table in Netcore DB 
select top 100 *  into mfss_contract_note from OpenQuery(PRCSN,'select * from mfss_contract_note where transaction_date between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from mfss_contract_note

-- Creating Allotment statement table in Netcore DB 
select top 100 * into allotment_statement from OpenQuery(PRCSN,'select * from allotment_statement where order_date between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from allotment_statement

-- creating redemption_statement table in netcore DB 
select top 100 * into redemption_statement from OpenQuery(PRCSN,'select * from redemption_statement where order_date between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from redemption_statement

-- creating dtm_contract_note_details table in netcore DB 
select top 100 * into dtm_contract_note_details from OpenQuery(PRCSN,'select * from dtm_contract_note_details where dcd_dt between To_date(''01-04-2016'',''dd-mm-yyyy'') and To_date(''31-03-2017'',''dd-mm-yyyy'')')
select * from dtm_contract_note_details