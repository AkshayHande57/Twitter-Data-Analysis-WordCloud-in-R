-- Analysis on EQ_contract_note_master_All_records table 

-- Table Name : EQ_contract_note_master_All_records
-- Number of columns : 54
-- Number of records : 11138733
-- Data Extraction done from : 1st April 2017 to 31st March 2018 ( 1 year Data ) 
EQ_contract_note_master_All_records
------------------------------------------------------------------------------------------------

select distinct(cnm_stc_no),count(*)
from EQ_contract_note_master_All_records
group by cnm_stc_no


select distinct(cnm_stc_stt_type),count(*)
from EQ_contract_note_master_All_records
group by cnm_stc_stt_type
/*
cnm_stc_stt_type	(No column name)
H	49
N	10709974
T	8350
W	372941
X	47419
*/

select distinct(cnm_stc_stt_exm_ID),count(*)
from EQ_contract_note_master_All_records
group by cnm_stc_stt_exm_ID
/*
cnm_stc_stt_exm_ID	(No column name)
BSE	2767058
NSE	8371675 
*/

select distinct(cnm_sd_stage),count(*)
from EQ_contract_note_master_All_records
group by cnm_sd_stage
/*
cnm_sd_stage	(No column name)
C	88233
F	11050500
*/

select distinct(cnm_other_fee),count(*)
from EQ_contract_note_master_All_records
group by cnm_other_fee

select distinct(cnm_audit),count(*)
from EQ_contract_note_master_All_records
group by cnm_audit

select distinct(cnm_prg_ID),count(*)
from EQ_contract_note_master_All_records
group by cnm_prg_ID
/*
cnm_prg_ID	(No column name)
CSSBCBGC	88231
CSSBGBIL	11050500
CSSFBIL27	2
*/


select distinct(cnm_can_remarks),count(*)
from EQ_contract_note_master_All_records
group by cnm_can_remarks
/*
cnm_can_remarks	(No column name)
NULL	11050500
Cancelled	88232
CHANGE IN BROKERAGE 05 to 02 ps	1
*/

select distinct(cnm_BRS_ID),count(*)
from EQ_contract_note_master_All_records
group by cnm_BRS_ID

select distinct(cnm_ref_code),count(*)
from EQ_contract_note_master_All_records
group by cnm_ref_code


select distinct(cnm_high_education_cess),count(*)
from EQ_contract_note_master_All_records
group by cnm_high_education_cess


select distinct(cnm_ent_state),count(*)
from EQ_contract_note_master_All_records
group by cnm_ent_state
/*
cnm_ent_state	(No column name)
LAKSHADWEEP	3
POLAND	1
RAK	4
SAFAT	5
SHAHARJAH	1
SULTANATE OF OMAN	1
ABU BHABI	2
FUJIRAH	2
IRELAND	1
SRI LANKA	5
AL QASSIM	2
K S A	3
MAHARASHTRA	3244562
U A E	1
ALHOORA	1
MANION	2
MELAKA	1
NAIROBI	2
RASLAFFAN	1
SAUDI ARABIA	103
ABU HALIFA	2
ANGOLA	4
APO	193
FAHAHEEL	1
HOORA	1
KANTO JAPAN	1
LOPBURI	4
AUCKLAND	4
BANGKAE	2
GYEONGGI DO	1
HAMBURG	1
INDONESIA	2
JAMMU AND KASHMIR	50703
JUBAIL	2
NEW SOUTH WALES	1
PHILIPPINES	8
ALMHULT	1
CHINA	3
HONG KONG	12
QUEENSLAND	2
SHUWAIKH	1
SINGAPORE	120
TELAVIV	1
UAE	7
YANBU	1
ANDAMAN AND NICOBAR	1049
HUNGARY	1
PRETORIA	1
RUWI	1
SULTANAT OF OMAN	2
ASTANA	1
DADRA AND NAGAR HAVELI	11356
GERMANY	6
KUALA LUMPUR	2
MESAIEED	1
NSW	1
NUSSBAUMEN	1
ONTARIO	4
PAPUA NEW GUINEA	1
ABU DHABI	112
ABUDHABI	23
DAMMAM KSA	3
LONDON	5
MUSCAT	38
ONTARIA	1
SIMEI	1
BANGLADESH	1
DAMAN AND DIU	6453
MIDDLESEX	1
OULU	4
SHARJAH	62
SOLOTHURN	1
SWITZERLAND	5
WEMBLEY	1
AL KABIR	1
QATAR	89
SELANGORE	1
TRIPURA	3179
UNITED KINGDOM	32
ASSAM	69700
DENMARK	2
ITALY	2
MADHYA PRADESH	285292
SECTEUR	1
SHARJH	1
SWINDON	4
THAILAND	7
TOKYO	4
WARWICKSHIRE	1
ZAMBIA	4
AEDUB DUBAI	1
BEDFORD	1
DAFZA	2
DERBY	3
DUABI	1
FRANCE	1
HARYANA	392309
HOLLAND	2
NAGALAND	967
RAS AL KHAIMA	1
RAUSSIA	1
SPAIN	2
SVR	2
EASTERN REGION	1
HONGKONG	3
IPSWICH	2
MEGHALAYA	10025
NETHERLANDS	1
PUDUCHERRY	12101
SIKKIM	4549
ABQAIQ	1
AL BAHA	1
DOHA	32
JAKARTA	3
KENYA	11
MANIPUR	1611
NIGERIA	6
RAS AL KHAIMAH	1
TANZANIA	1
TEXAS	3
ALKHOBAR	10
ANDHRA PRADESH	657411
AUH	1
CENTRAL	1
CHANDIGARH	43112
DAMMAM	6
SOUTHAMPTON	1
TAMIL NADU	736630
THAILA BANGKOK	1
UMM AL QUWAIN	2
WESTERN PROVINCE KSA	1
AJMAN	3
AL MAJAZ	2
DERBY SHIRE	3
GOA	79697
JAPAN	5
JHARKHAND	127622
UNITED ARAB EMIRATES	499
WEST BENGAL	635096
ALTRINNCHAM	1
BAHRAIN	39
BERKSHIRE	1
DUBAI	371
MALAYSIA	14
PUNJAB	248001
SOHAR	1
AHMADI	2
BANGKOK	1
DELHI	696805
JUNBAIL	1
KERALA	232661
KOBE	2
LUMPHUN	1
MANAMA	13
MIZORAM	694
OMAN	65
TELANGANA	165954
ATYRAU REGION	2
AUSTRALIA	22
BIHAR	171414
BRISTOL	1
EASTERN PROVINCE	6
FUJAIRAH	3
NEW ZEALAND	3
ODISHA	120927
RIYADH	20
UTTAR PRADESH	575445
BERLIN 	1
CHHATTISGARH	69228
JEDDAH	18
KARNATAKA	645192
KSA	2
KUWAIT	117
MERSEYSIDE	2
ONTAR	2
SANDTON	1
SURREY	1
BRICKFIELDS	2
DALIAN	1
GUJARAT	1159874
HIMACHAL PRADESH	61573
JAZAN	1
PORT SUDAN	1
VICTORIA	6
AL JUBAIL	2
ARUNACHAL PRADESH	925
BELGIUM	2
DHAHRAN	1
JEDDAN	1
MISSISSAUGA	1
N A	2
NOT IN INDIA	248848
RAJASTHAN	306559
RASTANURA	2
UTTARAKHAND	58911*/

select distinct(cnm_ent_UT_flag),count(*)
from EQ_contract_note_master_All_records
group by cnm_ent_UT_flag
/*
cnm_ent_UT_flag	(No column name)
NULL	2324540
N	8782743
Y	31450 */


select distinct(cnm_ent_branch_state),count(*)
from EQ_contract_note_master_All_records
group by cnm_ent_branch_state

