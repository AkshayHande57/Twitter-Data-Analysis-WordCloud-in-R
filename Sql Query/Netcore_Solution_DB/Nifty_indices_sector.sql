-- Working with Nifty List

/*
Download csv file from official website of NSE & Upload csv file to DB of each sector.

Combining multiple sectore wise table into one table.
1. Auto 
2. Bank 
3. Financial Services 
4. FMCG 
5. IT 
6. Media 
7. Metal 
8. Pharma 
9. Private Bank 
10. PSU 
11. Realty 

*/

-- Auto 
select * from [dbo].[ind_niftyautolist]
select count(1) from ind_niftyautolist -- 16

-- Private bank 
select * from [dbo].[ind_nifty_privatebanklist]
select count(1) from [dbo].[ind_nifty_privatebanklist] -- 10 

--------------------------------------------------------------------------------------------- 
-- Combining all nifty indices into one table 
select * into NSE_sec from [dbo].[ind_nifty_privatebanklist]
union 
select * from [dbo].[ind_niftyautolist]
union 
select * from [dbo].[ind_niftybanklist]
union 
select * from [dbo].[ind_niftyfinancelist]
union 
select * from [dbo].[ind_niftyfmcglist]
union 
select * from [dbo].[ind_niftyitlist]
union 
select * from [dbo].[ind_niftymedialist]
union 
select * from [dbo].[ind_niftymetallist]
union 
select * from [dbo].[ind_niftypharmalist]
union 
select * from [dbo].[ind_niftypsubanklist]
union 
select * from [dbo].[ind_niftyrealtylist]

select count(1) from NSE_sec
select * from NSE_sec

select industry, count(1) as 'Count' from NSE_sec
group by industry

select * from NSE_sec
