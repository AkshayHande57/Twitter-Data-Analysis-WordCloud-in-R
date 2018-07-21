select * from Entity_Master_with_lst_DT

select ENT_ID, ENT_BR_REG_DT,ENT_FIRST_TRD_DT,LST_TRD_DT
into ##Temp_Entity_Master 
from Entity_Master_with_lst_DT


select count(1) from ##Temp_Entity_Master --3009075
select count(distinct(ENT_ID)) from ##Temp_Entity_Master --3009075

select top 100 * from ##Temp_Entity_Master 

select * from Customer_Mix

select count(1) from Customer_Mix -- 653207

select count(1) from Customer_Mix where PREFERRED_PRODUCT = 'Margin' -- 39255
select count(1) from Customer_Mix where PREFERRED_PRODUCT = 'Margin' and ACTIVITY_RATIO = '< 33%'
-- 15206

select * into ##temp_Margin_Low from Customer_Mix 
where PREFERRED_PRODUCT = 'Margin' and ACTIVITY_RATIO = '< 33%'

select * from ##temp_Margin_Low 
select * from ##Temp_Entity_Master

select a.CUST_ID as 'Cust_ID',
PREFERRED_PRODUCT,
LAST_TRD_DT as 'LAST_TRD_DT_A',
REG_DT as 'REG_DT_A',
FIRST_TRD_DT as 'FIRST_TRD_DT_A',
ENT_FIRST_TRD_DT,
LST_TRD_DT as 'ENT_LST_TRD_DT'
into ##Margin_FIRST_TRD_DT
from ##temp_Margin_Low a left join ##Temp_Entity_Master b 
on a.CUST_ID = b.ENT_ID

select * from ##Margin_FIRST_TRD_DT

alter table ##Margin_FIRST_TRD_DT
add Flag varchar(10)

update ##Margin_FIRST_TRD_DT
set Flag = 
	case when FIRST_TRD_DT_A = ENT_FIRST_TRD_DT then 'YES'
	else 'No'
	end

select * from ##Margin_FIRST_TRD_DT
select Flag,count(1) from ##Margin_FIRST_TRD_DT group by Flag

select * from ##Margin_FIRST_TRD_DT where FIRST_TRD_DT_A >= cast('2017-04-01' as date) 
and REG_DT_A >= cast('2017-04-01' as date)


-------------------------------------------------------------------

select * from Customer_Mix


select a.CUST_ID,FIRST_TRD_DT,PREFERRED_PRODUCT,b.ENT_FIRST_TRD_DT into ##temp_dt
from Customer_Mix a left join Entity_Master_with_lst_DT b
on a.CUST_ID = b.ENT_ID 

select * from ##temp_dt 
alter table ##temp_dt 
add Flag varchar(10) 

update ##temp_dt
set flag =
	case when FIRST_TRD_DT = ENT_FIRST_TRD_DT then 'YES'
	else 'No'
	end

select flag,count(1)  from ##temp_dt group by flag