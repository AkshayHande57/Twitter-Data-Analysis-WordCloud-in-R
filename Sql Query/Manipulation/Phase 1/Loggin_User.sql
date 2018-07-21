-- Working on Login data 

-- Logged_Users_jn
select * from [dbo].[logged_users_jn]

-- Distinct Cust_ID 
select count(distinct(ILU_ENTITY_ID)) from [logged_users_jn] -- 2,83242

-- Number of records
select count(*) from logged_users_jn -- 19759402

-- Creating Login summary table 
select a.ILU_ENTITY_ID,count(a.ILU_Last_Login_Time) as 'Nos.Of.Time',max(ILU_Last_Login_Time) as 'Last_Login'
into Logged_User_summary_last
from logged_users_jn a
group by ILU_ENTITY_ID
order by count(a.ILU_Last_Login_Time) desc
-- (283243 row(s) affected)

select * from Logged_User_summary_last order by [Nos.of.Time] desc

-- Removing Null Entity_ID from the summary table.
select * into ##logged_summary_wo_null
from Logged_User_summary_last where ILU_ENTITY_ID is not null

select count(distinct(ILU_ENTITY_ID)) from ##logged_summary_wo_null -- 283242
select * from ##logged_summary_wo_null where ILU_ENTITY_ID is null 
select * from ##logged_summary_wo_null order by [Nos.of.Time] desc
------------------------------------------------------------------------------------------------
-- Looking at deciles for Nos.Of.time user has logged into system.
-- Deciles overall for unrealized_Pnl on customer level 
select [Nos.of.Time],ntile(10) over (order by [Nos.of.Time] desc) as 'Dc_Login_Time'
into #Temp_Deciles_logged_summary_wo_null
from ##logged_summary_wo_null
-- (283242 row(s) affected)


select Dc_Login_Time,min([Nos.of.Time]) as 'Min', 
max([Nos.of.Time]) as 'Max',avg([Nos.of.Time]) as 'Avg',
count([Nos.of.Time]) as 'count'
from #Temp_Deciles_logged_summary_wo_null
group by Dc_Login_Time
order by Dc_Login_Time

--------------------------------------------------------------------------------- 
-- Working on Venn Diagram for Customer_One_View & ##logged_summary_wo_null  table 
select * from ##logged_summary_wo_null
select count(distinct(ILU_ENTITY_ID)) as 'Count' from ##logged_summary_wo_null -- 283242
select count(1) as 'Count' from ##logged_summary_wo_null -- 283242
select * from Customer_Profile_MF_Data
select count(distinct(CUST_ID)) as 'Count' from Customer_Profile_MF_Data -- 653207

-- temp table
select a.Cust_ID,b.ILU_ENTITY_ID into ##Venn_Table
from Customer_Profile_MF_Data a full outer join ##logged_summary_wo_null b 
on a.Cust_ID = b.ILU_ENTITY_ID

--------------------------------------------------------------------------------------------
-- Venn Diagram 
select * from ##Venn_Table

-- Count 
select count(1) from ##Venn_Table -- 688028
select count(distinct(cust_ID)) from ##Venn_Table -- 653207
select count(distinct(ILU_ENTITY_ID)) from ##Venn_Table -- 283242

-- Common in both table. 
select count(1) from ##Venn_Table where Cust_ID is not null and ILU_ENTITY_ID is not null -- 248421

-- Only Login 
select count(1) from ##Venn_Table where Cust_ID is null and ILU_ENTITY_ID is not null -- 34821

-- Only One View 
select count(1) from ##Venn_Table where Cust_ID is not null and ILU_ENTITY_ID is null -- 404786

select count(1) from ##Venn_Table where Cust_ID is  null and ILU_ENTITY_ID is null -- 0

------------------------------------------------------------------------------------------
-- Login Count Buckets 
select * from ##logged_summary_wo_null

-- Creating Buckets for Count of Log_in 
alter table ##logged_summary_wo_null
add BK_login_Count varchar(20)

update ##logged_summary_wo_null
set BK_Login_Count = 
	case 
		when [Nos.of.Time] < 2 then '< 2' 
		when [Nos.of.Time] >= 2 and [Nos.of.Time] < 5 then '2 to 5'
		when [Nos.of.Time] >= 5 and [Nos.of.Time] < 10 then '5 to 10'
		when [Nos.of.Time] >= 10 and [Nos.of.Time] < 30 then '10 to 30'
		when [Nos.of.Time] >= 30 then '>= 30'
	end
-- (283242 row(s) affected)
 
-- Logged Detailed Count 
select BK_login_count,count(distinct(ilu_entity_ID)) as 'Logged_In_Count'
from ##logged_summary_wo_null
group by BK_login_count
order by count(distinct(ilu_entity_ID)) desc
/*
BK_login_count	Logged_In_Count
>= 30			92344
10 to 30		64296
2 to 5			56472
5 to 10			44967
< 2				25163
*/