-- Initial data exploration on Entity Master tables. 
-- View Top 50 customer details. 

select top 50 * from Entity_Master

select distinct(Ent_Type) , count(*) 
from Entity_Master 
group by Ent_type


/*
Ent_Type	(No column name)
BR	1
CL	2996704
DL	12032
SB	338
*/

select distinct(Ent_client_Type) , count(*) 
from Entity_Master 
group by Ent_client_type

/*
Ent_client_Type	(No column name)
FC	1273689
IC	1689132
NC	46254

*/

select distinct(Ent_seg_flag) , count(*) 
from Entity_Master 
group by Ent_seg_flag

/*
Ent_seg_flag	(No column name)
B	2684284
D	9
E	324782
*/
 
select distinct(Ent_category) , count(*) 
from Entity_Master 
group by Ent_category
/*
Ent_category	(No column name)
NULL	12371
FI	9760
NRI	69194
RCL	2917750
*/

select distinct(Ent_status) , count(*) 
from Entity_Master 
group by Ent_status
/*
Ent_status	(No column name)
D	1028909
E	1980160
P	6
*/

select Ent_ip_addr 
from Entity_Master 
where Ent_ip_addr  is not null 
-- Drop Ent_Ip_addr column.

select distinct(Ent_creat_BY) , count(*) 
from Entity_Master 
group by Ent_creat_BY


select distinct(Ent_cf_Flag) , count(*) 
from Entity_Master 
group by Ent_cf_Flag
/*
Ent_cf_Flag	(No column name)
N	1316242
Y	1692833
*/

select distinct(Ent_actv_level) , count(*) 
from Entity_Master 
group by Ent_actv_level
/*
Ent_actv_level	(No column name)
NULL	1280539
L	1728536
*/

select ent_cr_rating
from entity_master 
where ent_cr_rating is not null

select ent_gr_Id 
from entity_master
where ent_gr_id is not null 

select distinct ent_prg_id, count(*) 
from entity_master 
group by ent_prg_id
/*
ent_prg_id	(No column name)
ENTINTPRIV	336
NULL	298831
CSSBBANEN	165
DATA_MIG_M2P2	2
DATA_MIG_STPROF	24
BRANCHUPDT	1605
DISPMODE	45133
COLLUPDT	159492
CSSFMMT50	14
ADVPORT	8506
ITSLOGINUP	3125
EMAILUPDTND	2574
UPDTUCIN	431893
CSSFCLIAC	1031022
CSSFMMT26	26818
BRANUPDT	109701
NATIONUPDT	19
MFDLPRIV	4321
CSSFUCINRES	178989
ENTPRIV	13551
CLIADVUPDT	46658
CSSBGFUSC	401
CSSFMMT02	4786
DATA_MIG_35	2
IPRVUPDT	1558
CSSFIICR	3428
EMAILUPDT	106048
EMPFLUPDT	32
GSTINUPDT	1
CSSFUTRX	11097
INTERPRIV	137
UID_UPDT_FOS	79255
CLIADDUPDT	439551
*/

select distinct ent_prt_flg, count(*) 
from entity_master 
group by ent_prt_flg
/* 
ent_prt_flg	(No column name)
NULL	1611058
1	1398011
3	6
*/

select distinct ent_ctg_desc, count(*) 
from entity_master 
group by ent_ctg_desc
/*
ent_ctg_desc	(No column name)
NULL	10944
01	2894968
02	259
03	20391
04	3126
05	112
06	2168
07	75
08	6212
09	328
10	8
11	69195
12	405
15	19
16	25
18	344
22	71
23	5
42	1
49	1
99	418
*/

select distinct ent_ord_val, count(*) 
from entity_master 
group by ent_ord_val
/*
ent_ord_val	(No column name)
NULL	1266005
N	1358096
Y	384974
*/

select distinct ent_ml_flag, count(*) 
from entity_master 
group by ent_ml_flag
-- All values are NULL 

select distinct ent_emp_identity, count(*) 
from entity_master 
group by ent_emp_identity
/*
ent_emp_identity	(No column name)
E	30696
F	12
N	2978367
*/

select distinct ent_dispatch_mode, count(*) 
from entity_master 
group by ent_dispatch_mode
/*
ent_dispatch_mode	(No column name)
NULL	1025
C	497404
E	2491887
H	5800
N	12959
*/

select distinct ent_TT_FL, count(*) 
from entity_master 
group by ent_TT_FL
/*
ent_TT_FL	(No column name)
1	77756
2	2
3	2931317
*/

select distinct ent_REL_FL, count(*) 
from entity_master 
group by ent_REL_FL
/*
ent_REL_FL	(No column name)
N	14
Y	3009061
*/

---------------------------------------------------------------------------------
select distinct(ENT_Payout_type),count(*)
from Entity_Master
group by ENT_PAYOUT_TYPE


-- Desgination 
select distinct(ENT_DESIGNATION),count(*)
from Entity_Master
group by ENT_DESIGNATION

-- Edu Qualification 
select distinct(ENT_EDU_QUAL),count(*)
from Entity_Master
group by ENT_EDU_QUAL

-- Occupation 
select distinct(ENT_OCCUPATION),count(*)
from Entity_Master
group by ENT_OCCUPATION

-- martial Status 
select distinct(ENT_MARITAL_STATUS),count(*)
from Entity_Master
group by ENT_MARITAL_STATUS

-- Nationality 
select distinct(ENT_NATIONALITY),count(*)
from Entity_Master
group by ENT_NATIONALITY


-- Resi_staus 
select distinct(ENT_RESI_STATUS),count(*)
from Entity_Master
group by ENT_RESI_STATUS

-- Household Incone 
select distinct(ENT_HOUSEHOLD_INCOME_3),count(*)
from Entity_Master
group by ENT_HOUSEHOLD_INCOME_3

-- SMS Alert 
select distinct(ENT_SMS_ALERT_FL),count(*)
from Entity_Master
group by ENT_SMS_ALERT_FL


-- MObile Trading 
select distinct(ENT_MOBILE_TRADING),count(*)
from Entity_Master
group by ENT_MOBILE_TRADING


-- Online-Payout 
select distinct(ENT_ONLINE_PAYOUT),count(*)
from Entity_Master
group by ENT_ONLINE_PAYOUT

-- Bank Category 
select distinct(ENT_FULL_FUNDS_PAYOUT),count(*)
from Entity_Master
group by ENT_FULL_FUNDS_PAYOUT

-- Status 
select distinct(ENT_STATUS),count(*)
from Entity_Master
group by ENT_STATUS

-- DMA_ACCESS 
select distinct(ENT_DMA_ACCESS),count(*)
from Entity_Master
group by ENT_DMA_ACCESS


-- client Interface 
select distinct(ENT_CLIENT_INTERFACE),count(*)
from Entity_Master
group by ENT_CLIENT_INTERFACE


-- Order Confrim
select distinct(ENT_ORDER_CONFIRM),count(*)
from Entity_Master
group by ENT_ORDER_CONFIRM

-- Trade Confrim 
select distinct(ENT_TRD_CONFIRM),count(*)
from Entity_Master
group by ENT_TRD_CONFIRM
/*
ENT_ORDER_CONFIRM	(No column name)
E	2702425
I	67624
N	239026*/

/*
ENT_TRD_CONFIRM	(No column name)
1	4595
E	96699
I	58045
N	2849736*/


select distinct(TRD_SIP_FLAG) ,count(*)
from EQ_Trades_Q1
group by TRD_SIP_FLAG
/*
TRD_SIP_FLAG	(No column name)
NULL	174
N	14624712
Y	361993 */
