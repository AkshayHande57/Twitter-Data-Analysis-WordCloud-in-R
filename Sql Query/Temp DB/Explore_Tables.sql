-- Exploring Entity_Master Table 
select * from Entity_Master

select count(*) from Entity_Master

select distinct( Ent_type), count(*) from Entity_Master group by ENT_TYPE
-- Ent_Type = CL = 100 

-- Two Distinct Groups For Client_Type
select distinct( ENT_CLIENT_TYPE), count(*) from Entity_Master group by ENT_CLIENT_TYPE
-- FC	99
-- IC	1

select distinct(ENT_SEG_FLAG), count(*) from Entity_Master group by ENT_SEG_FLAG