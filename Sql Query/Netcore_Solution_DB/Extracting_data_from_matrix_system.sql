-- Extracting data from IPO transaction table to Netcore Solution DB for past 6 months.
select * into ipo_appln 
from OpenQuery(IPORO,'select * from ipo_appln
where IAN_DT between To_date(''01-10-2017'',''dd-mm-yyyy'') and To_date(''31-03-2018'',''dd-mm-yyyy'')')

-- 2995241 rows extracted 
-- Columns : 121
-- Duration : 30.39 mins

-- IAN_TRNSCTN_NMBR
-- IAN_DT
-- IAN_STATUS
-- IAN_INT_STATUS
-- IAN_TYPE 
-- IAN_EXCH_OFF_MKT_FLG
-- IAN_MAIL_FLG
-- IAN_ACC_TYPE

select top 100 * from ipo_appln





