-- Exploring table Contract note details 

-- All values 
select * from Contract_note_details

-- Display Distinct cnd_ENT_ID with count 
select distinct(cnd_ent_id) , count(*) from Contract_note_details group by CND_ENT_ID

select distinct(CND_PRODUCT_TYPE) , count(*) from Contract_note_details group by CND_PRODUCT_TYPE
-- CND_PRODUCT_TYPE	(No column name)
-- CNC		18
-- MARGIN	82

select distinct(CND_CHM_ID) , count(*) from Contract_note_details group by CND_CHM_ID
-- cnd-chm_Id  Count
-- ITS	14
-- OWS	4
-- TWS	82

select distinct(CND_SEM_ID) , count(*) from Contract_note_details group by CND_SEM_ID
/*AMTAUTEQ	5
ASTMICEQ	28
BHELTDEQ	12
BSELTDEQ	2
HINZINEQ	3
ICIBANEQ	12
IDECELEQ	19
SURROSEQ	1
SUZLTDEQ	4
WHIINDEQ	14
*/

select distinct(CND_CNM_NO) , count(*) from Contract_note_details group by CND_CNM_NO