-- TRD_ND_FLG
select TRD_ND_FLG , count(*)
from EQ_Trades_Q3_Q4
group by TRD_ND_FLG
/*
TRD_ND_FLG	(No column name)
N	35139162
*/
-- All Values are marked as N ignoring this column.

-- TRD_SP_SET_FLG
select TRD_SP_SET_FLG , count(*)
from EQ_Trades_Q3_Q4
group by TRD_SP_SET_FLG
/*
TRD_SP_SET_FLG	(No column name)
N	35139162
*/
-- All Values are marked as N ignoring this column

-- TRD_CF_TYPE
select TRD_CF_TYPE , count(*)
from EQ_Trades_Q3_Q4
group by TRD_CF_TYPE
-- All NULL Values present dropping column.

-- TRD_CF_TENURE
select TRD_CF_TENURE , count(*)
from EQ_Trades_Q3_Q4
group by TRD_CF_TENURE
-- All NULL Values present dropping column.

-- TRD_SA_FLG
select TRD_SA_FLG , count(*)
from EQ_Trades_Q3_Q4
group by TRD_SA_FLG
-- All Values are marked as N ignoring this column

-- TRD_TMM_PROD_ID
select TRD_TMM_PROD_ID , count(*)
from EQ_Trades_Q3_Q4
group by TRD_TMM_PROD_ID
-- All Values are marked as M ignoring this column

-- TRD_CHM_ID
select TRD_CHM_ID , count(*)
from EQ_Trades_Q3_Q4
group by TRD_CHM_ID
/*
TRD_CHM_ID	(No column name)
DEFAULT		9723538
ITS			10069895
OWS			5424283
SPOT		969
TWS			9920477
*/

-- TRD_IND_FLG
select  TRD_IND_FLG , count(*)
from EQ_Trades_Q3_Q4
group by  TRD_IND_FLG
/*
TRD_IND_FLG	(No column name)
1B	889494
1S	495944
2B	325538
2S	266391
3	33161795
*/

-- TRD_GTDT_FLAG
select  TRD_GTDT_FLAG , count(*)
from EQ_Trades_Q3_Q4
group by  TRD_GTDT_FLAG
/*
TRD_GTDT_FLAG	(No column name)
NULL			47582
N				34977567
Y				114013
*/


-- TRD_SOR_FLAG
select  TRD_SOR_FLAG , count(*)
from EQ_Trades_Q3_Q4
group by  TRD_SOR_FLAG

-- TRD_RECON
select  TRD_RECON , count(*)
from EQ_Trades_Q3_Q4
group by  TRD_RECON
/*
TRD_GTDT_FLAG	(No column name)
NULL	47582
N	34977567
Y	114013
*/

-- TRD_REPORTING_STATUS
select  TRD_REPORTING_STATUS , count(*)
from EQ_Trades_Q3_Q4
group by  TRD_REPORTING_STATUS
-- All values marked as I for Reporting Status ignoring this column.

-- [TRD_STC_STT_TYPE]
select  TRD_STC_STT_TYPE , count(*)
from EQ_Trades_Q3_Q4
group by  TRD_STC_STT_TYPE
/*
TRD_STC_STT_TYPE	(No column name)
H					14
N					34467652
T					965
W					623928
X					46603
*/

