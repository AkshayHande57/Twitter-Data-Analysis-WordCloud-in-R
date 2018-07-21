-- Working on Low Revenue Customer base for Delivery & Margin. 

select * from Customer_Profile_MF_Data

select Preferred_Product,Online_offline,count(distinct(cust_ID)) as 'Count'
from Customer_Profile_MF_Data
where (Preferred_Product = 'DELIVERY' and BRKG_AM = '0 to 150') or 
(Preferred_Product = 'MARGIN' and BRKG_AM = '0 to 500')
group by Preferred_Product,Online_offline
/*
Preferred_Product	Online_offline	Count
DELIVERY			Both			16388
DELIVERY			Ofl				148575
DELIVERY			OnL				145860
*/

-- Only Delivery base Customer 
select Preferred_Product,Online_offline,count(distinct(cust_ID)) as 'Count'
from Customer_Profile_MF_Data
where (Preferred_Product = 'DELIVERY' and BRKG_AM = '0 to 150') 
group by Preferred_Product,Online_offline
/*
Preferred_Product	Online_offline	Count
DELIVERY			Both			16388
DELIVERY			Ofl				148575
DELIVERY			Onl				145860

*/

--------------------------------------------------------------------------
-- Only Margin Base 
select Preferred_Product,Online_offline,count(distinct(cust_ID)) as 'Count'
from Customer_Profile_MF_Data
where (Preferred_Product = 'MARGIN' and BRKG_AM = '0 to 500')
group by Preferred_Product,Online_offline