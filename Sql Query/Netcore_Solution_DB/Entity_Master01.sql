select top 100 * from Entity_Master

-- Total Count of customer : 3009075
select count(*)
from Entity_Master

-- Total Count of customer by status 
select distinct(ent_status), count(*)
from Entity_Master
group by ENT_STATUS
/*
ent_status	(No column name)
D			1028909
E			1980160
P			6
*/
-- Extract details of all customer who have status 'P' 
select * from Entity_Master where ENT_STATUS like 'P'

-- Distinct count of Ent_type 
select distinct(ENT_TYPE),count(*) from Entity_Master group by ENT_TYPE
/*ENT_TYPE	(No column name)
BR	1
CL	2996704
DL	12032
SB	338
*/

-- Ent_Client_type 
select distinct(ENT_CLIENT_TYPE),count(*) from Entity_Master group by ENT_client_TYPE
/*
ENT_CLIENT_TYPE	(No column name)
FC	1273689
IC	1689132
NC	46254
*/

-- Ent_Seg_Flag
select distinct(ENT_SEG_FLAG),count(*) from Entity_Master group by ENT_SEG_FLAG
/*
ENT_SEG_FLAG	(No column name)
B	2684284
D	9
E	324782
*/

-- Ent_category
select distinct(ENT_CATEGORY),count(*) from Entity_Master group by ENT_CATEGORY
/*
ENT_CATEGORY	(No column name)
NULL	12371
FI	9760
NRI	69194
RCL	2917750
*/


-- Adding New Age Column in Entity_Master table
ALTER TABLE Entity_Master
ADD Age as (DATEDIFF(year, ENT_DOB, GETDATE()))


-- Distinct state wise count
select distinct(ENT_ADDRESS_LINE_5),count(*)
from Entity_Master
group by ENT_ADDRESS_LINE_5

-- Distinct Maritial Status 
select distinct(ENT_MARITAL_STATUS),count(*)
from Entity_Master
group by ENT_MARITAL_STATUS
