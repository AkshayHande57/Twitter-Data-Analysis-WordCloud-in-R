-- Currency related tables
select top 1000 * from cur_charges_validity
select top 1000 * from cur_contract_note_details
select top 1000 * from cur_contract_note_master
select top 1000 * from cur_trades

-- Derivaties related tables 
select top 1000 * from [dbo].[dtm_charges_validity]
select top 1000 * from [dbo].[dtm_contract_note_details_All_records]
select top 1000 * from [dbo].[dtm_contract_note_master_All_records]
select top 1000 * from [dbo].[dtm_trades_All_records]

-- Equity related tables 
select top 1000 * from [dbo].[eq_charges_validity]
select top 1000 * from [dbo].[EQ_security_price_info]
select top 1000 * from [dbo].[EQ_Trades_Q1_Q2]
select top 1000 * from [dbo].[EQ_Trades_Q3_Q4]
select top 1000 * from [dbo].[EQ_contract_note_master_All_records]

-- Entity_master 
select top 1000 * from [dbo].[Entity_Master]
select top 1000 * from [dbo].[Entity_Master_lst_date]

-- Mutual Funds 
select top 1000 * from [dbo].[allotment_statement]
select top 1000 * from [dbo].[redemption_statement]
select top 1000 * from [dbo].[mfss_trades]
select top 1000 * from [dbo].[mfss_contract_note]


-- Customer Login 
select top 1000 * from [dbo].[logged_users_jn]

-- Stock Code Master
select top 1000 * from [dbo].[stock_code_master]

-- Stock price History 
select top 1000 * from [dbo].[EQ_security_price_info]

-- IPO Details 
select top 1000 * from [dbo].[ipo_appln]