select * from Entity_Master

-- Count of Entity and Deriviaties
select distinct(Ent_status),count(*)
from Entity_Master
group by ENT_STATUS
/*
Ent_status	(No column name)
D	58
E	42
*/

-- Display distinct Ent_prg_ID 
select distinct(ENT_PRG_ID),count(*)
from Entity_Master
group by ENT_PRG_ID


-- Display first transaction date 
select distinct(ent_first_trd_dt),count(*)
from Entity_Master
group by ENT_FIRST_TRD_DT

select ent_first_trd_dt,count(*) from Entity_Master where year(ENT_FIRST_TRD_DT) > 2005
group by ENT_FIRST_TRD_DT






/*
ENT_PRG_ID	(No column name)
NULL	11
BRANUPDT	3
CLIADVUPDT	1
COLLUPDT	5
CSSFCLIAC	21
CSSFUCINRES	2
EMAILUPDT	27
ENTPRIV		2
UID_UPDT_FOS 5
UPDTUCIN	 23
*/


select distinct(ENT_DISPATCH_MODE),count(*)
from Entity_Master
group by ENT_DISPATCH_MODE
/*
ENT_DISPATCH_MODE	(No column name)
C	70
E	30
*/

select Distinct(ENT_OCCUPATION),count(*) 
from Entity_Master
group by ENT_OCCUPATION
/*
ENT_OCCUPATION	(No column name)
NULL	51
BUSINESS	2
Employed	2
Housewife	2
OTHERS	2
Private Sector	13
Professional	23
PUBLIC SECTOR	2
Retired	1
SELFEMPLOYED	1
STUDENT	1
*/

