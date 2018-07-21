-- Working with Currency related table 

------- Currency Related Tables -------

-- Query Execution for Cur_trades is ongoing.
-- Extracting Data from cur_trades table to Netcore_solution_DB 
select  * into cur_trades from OpenQuery(PRCSN,'select * from cur_trades
where DTR_DT between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- 33061 records present in cur_trades tables.
select * from cur_trades

-- Extracting Data from cur_contract_note_master table to Netcore_solution_DB
select * into cur_contract_note_master from OpenQuery(PRCSN,'Select * from cur_contract_note_master
where dcn_date between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- 9199 Rows present in cur_contract_note_master Table. -- Execution Time : 20 Sec.
select * from cur_contract_note_master

-- Extracting Data from cur_contract_note_details table to Netcore_solution_DB
select * into cur_contract_note_details from OpenQuery(PRCSN,'select * from cur_contract_note_details
where dcd_dt between To_date(''01-04-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')
-- 33834 rows present in cur_contract_note_details tables.
select * from cur_contract_note_details


-- List of columns having NULL Values.
-- DTR_Cp_CD 
-- DTR_MIS_DEAL_TYPE
-- DTR_REMARKS
-- DTR_CONSOLIDATION_ID
-- DTR_ALLOCATION_ID
-- DTR_ORIG_CHANNEL_TYPE
-- DTR_OASYS_BLIM_REF_NO 
-- DTR_ORDER_INSTR_NO 
-- DTR_BATCH_NO
-- DTR_SUPER_ID 
-- DTR_EXM_STATUS
-- DTR_MC_FLG
-- DTR_CUS_CONF_FLG
-- DTR_OLD_CUS_CONF_FLG
-- DTR_CUS_CONF_DT 
-- DTR_PRO_MIS_DEAL_FLG
-- DTR_ENT_DERV_CTRL_ID 
-- DTR_OLD_ENT_DERV_CLTRL_ID
-- DTR_SERIAL_NO 
-- DTR_BUY_LOC_ID 
-- DTR_SELL_LOC_ID 
-- DTR_BASKET_ID
-- DTR_PORTFOLIO_ID
-- DTR_BRK_MTH_TURNOVER
-- DTR_TMM_PROD_ID 
-- DTR_SOL_FLG
-- DTR_SOL_UNSOL_TYPE
-- DTR_SOL_REMARKS
-- DTR_TRADER_ID 
-- DTR_SQUP_QTY_TG

