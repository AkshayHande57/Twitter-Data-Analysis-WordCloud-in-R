select top 100 * from ##Delivery_Bonus_Pre_summary_Close_Price

-- Bonus Declared Scrips 
select count(1) from ##Delivery_Bonus_Pre_summary_Close_Price -- 189775
select count(1) from ##Delivery_Bonus_Post_Summary_Close_price --598643 

-- Non Bonus Declared Scrips.
select count(1) from ##Delivery_summary_NonBonus_Close_price -- 5810415
