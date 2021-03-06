/*
Join tables: dtm_trades_all_records and dtm_contract_note_details_All records 
Creating new table which holds records for both derivaties transaction & pure brokeage amount


*/

select [DTR_TRD_NO]
      ,[DTR_EXM_ID]
      ,[DTR_ORD_NO]
      ,[DTR_ORD_TIME]
      ,[DTR_DT]
      ,[DTR_TIME]
      ,[DTR_ENT_ID]
      ,[DTR_ENT_DERV_CTRL_ID]
      ,[DTR_DCM_ID]
      ,[DTR_DST_TYPE]
      ,[DTR_EXPIRY_DT]
      ,[DTR_STRIKE_PRICE]
      ,[DTR_BUY_SELL_FLG]
      ,[DTR_QTY]
      ,[DTR_PRICE]
      ,[DTR_TMM_PROD_ID]
      ,[DTR_CHM_ID]
      ,[DTR_EXM_STATUS]
      ,[DTR_CHANNEL_TYPE]
      ,[DTR_USER_ID]
      ,[DTR_SUPER_ID]
      ,[DTR_BRK_MTH_TURNOVER]
      ,[DTR_SQUP_QTY]
      ,[DTR_CLOSE_OUT_QTY]
      ,[DTR_SQUP_SECOND_LEG_QTY]
      ,[DTR_LAST_ACTIVITY_TIME]
      ,[DTR_PRODUCT_TYPE]
      ,[DTR_CONTRACTS]
      ,[DTR_SHORT_CODE]
      ,[DCD_DCN_NO]
      ,[DCD_SEQ_NO]
      ,[DCD_STAGE]
      ,[DCD_TRADE_TIME]
      ,[DCD_DST_TYPE]
      ,[DCD_BUY_SELL_FLG]
      ,[DCD_QTY]
      ,[DCD_PRICE]
      ,[DCD_PREMIUM]
      ,[DCD_BROKERAGE_RATE]
      ,[DCD_TRADE_SQUP_FLAG]
      ,[DCD_STD_DET_AMT]
      ,[DCD_SET_DET_AMT]
      ,[DCD_TOT_DET_AMT]
      ,[DCD_OTC_DET_AMT]
      ,[DCD_REG_LOT]
      ,[DCD_CHM_ID]
      ,[DCD_COMPUTED_BROKERAGE_RATE]
      ,[DCD_STT_DET_AMT]
      ,[DCD_SQRD_QTY]
      ,[DCD_SOT_DET_AMT]
      ,[DCD_PURE_BRK]
      ,[DCD_TRD_CLOSE_OUT_QTY]
      ,[DCD_SQUP_SEC_LEG_QTY]
      ,[DCD_DT]
      ,[DCD_NET_RATE]
into dtm_trades_CND
from dtm_trades_All_records T 
left join dtm_contract_note_details_All_records cnd 
on 
T.DTR_TRD_NO = cnd.DCD_TRADE_NO and 
t.DTR_ORD_NO = cnd.DCD_ORDER_NO and 
T.DTR_DT = cnd.DCD_DT and 
T.DTR_ENT_ID = cnd.DCD_ENT_ID and
T.DTR_DCM_ID = cnd.DCD_DCM_ID

-- Joins rows (6098815) row(s) affected  Duration : 4.49mins

-- Spliting dtm_dcn_id into two columns.
update dtm_trades_CND
set dcd_scrip_code = SUBSTRING(dtr_dcm_id,8,10)


alter table dtm_trades_cnd
add Indx_stock varchar(15)

update dtm_trades_CND
set Indx_stock = SUBSTRING(dtr_dcm_id,4,3)

select * from dtm_trades_CND






