/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [DTR_TRD_NO]
      ,[DTR_EXM_ID]
      ,[DTR_SEQ_NO]
      ,[DTR_ORD_NO]
      ,[DTR_ORD_TIME]
      ,[DTR_DT]
      ,[DTR_TRADE_TIME]
      ,[DTR_EAM_BROKER_ID]
      ,[DTR_ENT_ID]
      ,[DTR_OLD_ENT_ID]
      ,[DTR_DCM_ID]
      ,[DTR_BUY_SELL_FLG]
      ,[DTR_QTY]
      ,[DTR_PRICE]
      ,[DTR_CP_CD]
      ,[DTR_DCN_NO]
      ,[DTR_MIS_DEAL_TYPE]
      ,[DTR_STATUS]
      ,[DTR_CREAT_BY]
      ,[DTR_CREAT_DT]
      ,[DTR_LAST_UPDT_BY]
      ,[DTR_LAST_UPDT_DT]
      ,[DTR_PRG_ID]
      ,[DTR_REMARKS]
      ,[DTR_CONSOLIDATION_ID]
      ,[DTR_CHANNEL_TYPE]
      ,[DTR_USER_ID]
      ,[DTR_ALLOCATION_ID]
      ,[DTR_OLD_CP_CD]
      ,[DTR_SQUP_QTY]
      ,[DTR_CLOSE_OUT_QTY]
      ,[DTR_SQUP_SECOND_LEG_QTY]
      ,[DTR_ORIG_CHANNEL_TYPE]
      ,[DTR_OASYS_BLIM_REF_NO]
      ,[DTR_ORDER_INSTR_NO]
      ,[DTR_BATCH_NO]
      ,[DTR_SUPER_ID]
      ,[DTR_EXM_STATUS]
      ,[DTR_MC_FLG]
      ,[DTR_CUS_CONF_FLG]
      ,[DTR_OLD_CUS_CONF_FLG]
      ,[DTR_CUS_CONF_DT]
      ,[DTR_PRO_MIS_DEAL_FLG]
      ,[DTR_DST_TYPE]
      ,[DTR_EXPIRY_DT]
      ,[DTR_STRIKE_PRICE]
      ,[DTR_ENT_DERV_CTRL_ID]
      ,[DTR_OLD_ENT_DERV_CTRL_ID]
      ,[DTR_SERIAL_NO]
      ,[DTR_CONTRACTS]
      ,[DTR_BUY_LOC_ID]
      ,[DTR_SELL_LOC_ID]
      ,[DTR_BASKET_ID]
      ,[DTR_PORTFOLIO_ID]
      ,[DTR_BRK_MTH_TURNOVER]
      ,[DTR_TMM_PROD_ID]
      ,[DTR_SOL_FLG]
      ,[DTR_SOL_UNSOL_TYPE]
      ,[DTR_SOL_REMARKS]
      ,[DTR_MARGIN_CALL]
      ,[DTR_CHM_ID]
      ,[DTR_TRADER_ID]
      ,[DTR_TERMINAL_ID]
      ,[DTR_SQUP_QTY_TG]
  FROM [Netcore_solution_DB].[dbo].[cur_trades] 
  where DTR_ENT_ID = '2474744' and DTR_DT ='2018-03-26 00:00:00.0000000'