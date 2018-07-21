-- Adding all Index to all list of tables present in Netcore_Solution_tables 

-- Syntax : -- CREATE INDEX i1 ON t1 (col1); 

-- Adding Index on allotment_statement table.
create index allotment_statement_Index on [dbo].[allotment_statement] (Order_No)

-- Adding Index on redemption_statement table.
[dbo].[redemption_statement]
create index redemption_statement_Index on [dbo].[redemption_statement] (Order_No)

-- Adding Index on mfss_contract_note table.
[dbo].[mfss_contract_note]
create index mfss_contract_note_Index on [dbo].[mfss_contract_note] (ENT_ID)

-- Adding index on [dbo].[cur_charges_validity]
select  * from [dbo].[cur_charges_validity]
create index cur_charges_validity_Index on [dbo].[cur_charges_validity] (DTM_ENT_ID)

-- Adding index on [dbo].[dtm_charges_validity]
select  * from [dbo].[dtm_charges_validity]
create index dtm_charges_validity_Index on [dbo].[dtm_charges_validity] (DTM_ENT_ID)

-- Adding index on [dbo].[dtm_charges_validity]
select  * from [dbo].[eq_charges_validity]
create index eq_charges_validity_Index on [dbo].[eq_charges_validity] (ECV_ENT_ID)

-- Adding index on [dbo].[Entity_Master]
select  * from [dbo].[Entity_Master]
create index Entity_Master_Index on [dbo].[Entity_Master] (ENT_ID)

-- Adding index on [dbo].[EQ_Trades_Q1_Q2]
select top 100  * from [dbo].[EQ_Trades_Q1_Q2]
select distinct(TRD_No),count(*) from EQ_Trades_Q1_Q2 group by TRD_NO
create index EQ_Trades_Q1_Q2_Index on [dbo].[EQ_Trades_Q1_Q2] (TRD_NO)

-- Adding index on [dbo].[EQ_Trades_Q3_Q4]
select top 100  * from [dbo].[EQ_Trades_Q3_Q4]]
select distinct(TRD_No),count(*) from EQ_Trades_Q1_Q2 group by TRD_NO
create index EQ_Trades_Q3_Q4_Index on [dbo].[EQ_Trades_Q3_Q4] (TRD_NO)

-- Adding index on [dbo].[EQ_Trades_Full]
create index EQ_Trades_Full_Index on [dbo].[EQ_Trades_Full] (TRD_NO)
-- Duration : 12.37 mins

-- Adding index on [dbo].[stock_code_master] tables.
select  * from [dbo].[stock_code_master]
create index stock_code_master_index on [dbo].[stock_code_master] ( SEM_EXCH_SECURITY_ID ) 

-- Adding index on [dbo].[EQ_security_price_info]
select  top 100 * from [dbo].[EQ_security_price_info]
create index EQ_security_price_info_index on [dbo].[EQ_security_price_info] ( SPI_DT ) 

-- Adding index on [dbo].[EQ_contract_note_master_All_records]
select  top 100 * from [dbo].[EQ_security_price_info]
create index EQ_contract_note_master_All_records_index 
on  [dbo].[EQ_contract_note_master_All_records] (cnm_no) 

-- Adding index on [dbo].[dtm_trades_All_records]
select  top 100 * from [dbo].[dtm_trades_All_records]
create index dtm_trades_All_records_index 
on  [dbo].[dtm_trades_All_records] (DTR_TRD_NO) 

-- Adding index on [dbo].[dtm_contract_note_master_All_records]
select  top 100 * from [dbo].[dtm_contract_note_master_All_records]
create index dtm_contract_note_master_All_records_index 
on  [dbo].[dtm_contract_note_master_All_records] (DCN_NO)

-- Adding index on [dbo].[dtm_contract_note_details_All_records]
select  top 100 * from [dbo].[dtm_contract_note_master_All_records]
create index dtm_contract_note_details_All_records_index 
on  [dbo].[dtm_contract_note_details_All_records] (dcd_dcn_no)

-- Adding index on [dbo].[cur_trades]
select  top 100 * from [dbo].[cur_trades]
create index cur_trades_index on  [dbo].[cur_trades] (DTR_TRD_NO)

-- Adding index on [dbo].[cur_contract_note_master]
select  top 100 * from [dbo].[cur_contract_note_master]
create index cur_contract_note_master_index on  [dbo].[cur_contract_note_master] (DCN_NO)

-- Adding index on [dbo].[cur_contract_note_details]
select  top 100 * from [dbo].[cur_contract_note_details]
create index cur_contract_note_details_index on [dbo].[cur_contract_note_details] (DCD_DCN_NO)
