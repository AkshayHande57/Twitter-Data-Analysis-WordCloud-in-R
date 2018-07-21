-- Working on MF data. 

select * from mfss_trades

-- Number of MF Trades in mfss_Trades tables. 
select count(*) from mfss_trades -- 3095979

-- NUmber of distinct Customer who have traded in MF 
select count(distinct(ENT_ID)) from mfss_trades -- 180698 

-- Creating separate table for customer who have traded in MF 
select distinct ENT_ID into ##mf_distinct_cust from mfss_trades
-- (180698 row(s) affected) 

-- distinct cust count 
select count(distinct(ent_ID)) from ##mf_distinct_cust -- 180698
--------------------------------------------------------------------------------
-- Adding MF_FLG to ##mf_distinct_cust table. 
alter table ##mf_distinct_cust
add MF_FLG varchar(20)

update ##mf_distinct_cust 
set MF_FLG = 'YES'
-- (180698 row(s) affected)

select * from ##mf_distinct_cust

select MF_FLG,count(distinct(ENT_ID)) as 'Count'
from ##mf_distinct_cust group by MF_FLG
/*
MF_FLG	Count
YES		180698
*/
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Customer_Profile One View table 
select * from Customer_Profile

-- Joining Customer_profile table with ##Mf_Distinct_cust
select a.*,b.MF_FLG into ##Customer_Profile_MF_Data
from Customer_Profile a left join ##mf_distinct_cust b 
on a.cust_ID = b.ENT_ID
-- (653207 row(s) affected)

select * from ##Customer_Profile_MF_Data

------------------------------------------------------------------------------
-- Profile_Flg VS MF_Flg
select Profile_Flg,MF_FLG,count(distinct(Cust_ID)) as 'Count'
from ##Customer_Profile_MF_Data 
group by Profile_Flg,MF_FLG
order by count(distinct(Cust_ID)) desc


-- MF_FLG Count 
select MF_FLG,count(distinct(Cust_ID)) as 'Count'
from ##Customer_Profile_MF_Data 
group by MF_FLG
order by count(distinct(Cust_ID)) desc
/*
MF_FLG	Count
NULL	508928
YES		144279
*/

-------------------------------------------------------------------------------
-- Distinct Customer Count across City Variable.
select * from ##Customer_Profile_MF_Data

 select City,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Customer_Profile_MF_Data 
 group by City 
 order by count(distinct(cust_ID)) desc

 -- Extracting Top 1000 City which gives around cust count of 91%.
 select top 1000 City,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Customer_Profile_MF_Data 
 group by City 
 order by count(distinct(cust_ID)) desc

 -- City Vs Profile_FLG 
 -- Extracting Top 1000 City which gives around cust count of 91%.
 select City,Profile_Flg,count(distinct(cust_ID)) as 'Unique_Cust_Count'
 from ##Customer_Profile_MF_Data 
 where city = 'MUMBAI ' or 
 city = 'PUNE '  or
city = 'CHENNAI '  or
city = 'BENGALURU '  or
city = 'KOLKATA '  or
city = 'AHMEDABAD '  or
city = 'THANE '  or
city = 'NEW DELHI '  or
city = 'DELHI '  or
city = 'HYDERABAD '  or
city = 'NAVI MUMBAI '  or
city = 'VADODARA '  or
city = 'GURGAON '  or
city = 'BANGALORE '  or
city = 'JAIPUR '  or
city = 'SURAT '  or
city = 'NASHIK '  or
city = 'RAJKOT '  or
city = 'GHAZIABAD '  or
city = 'INDORE '  or
city = 'LUCKNOW '  or
city = 'FARIDABAD '  or
city = 'DUBAI '  or
city = 'NAGPUR '  or
city = 'NOIDA '  or
city = 'PATNA '  or
city = 'COIMBATORE '  or
city = 'AURANGABAD '  or
city = 'CHANDIGARH '  or
city = 'JAMNAGAR '  or
city = 'LUDHIANA '  or
city = 'VISAKHAPATNAM '  or
city = 'BHOPAL '  or
city = 'BHARUCH '  or
city = 'HOWRAH '  or
city = 'ERNAKULAM '  or
city = 'THRISSUR '  or
city = 'KANPUR '  or
city = 'BHAVNAGAR '  or
city = 'HOOGHLY '  or
city = 'GUNTUR '  or
city = 'JALGAON '  or
city = 'JAMSHEDPUR '  or
city = 'SECUNDERABAD '  or
city = 'AMRITSAR '  or
city = 'GANDHINAGAR '  or
city = 'AGRA '  or
city = 'GUWAHATI '  or
city = 'KOLHAPUR '  or
city = 'RANCHI '  or
city = 'AHMEDNAGAR '  or
city = 'JALANDHAR '  or
city = 'SALEM '  or
city = 'ALLAHABAD '  or
city = 'SANGLI '  or
city = 'GWALIOR '  or
city = 'BHUBANESWAR '  or
city = 'SATARA '  or
city = 'JAMMU '  or
city = 'PANCHKULA '  or
city = 'RANGAREDDY '  or
city = 'UDAIPUR '  or
city = 'MADURAI '  or
city = 'RAIPUR '  or
city = 'MEERUT '  or
city = 'DEHRADUN '  or
city = 'JABALPUR '  or
city = 'PALAKKAD '  or
city = 'MOHALI '  or
city = 'VARANASI '  or
city = 'ABU DHABI '  or
city = 'AKOLA '  or
city = 'ERODE '  or
city = 'KARIMNAGAR '  or
city = 'PATIALA '  or
city = 'JODHPUR '  or
city = 'MYSORE '  or
city = 'HISAR '  or
city = 'SRINAGAR '  or
city = 'CUTTACK '  or
city = 'AMRAVATI '  or
city = 'GORAKHPUR '  or
city = 'RAIGARH '  or
city = 'BARODA '  or
city = 'KRISHNA '  or
city = 'NELLORE '  or
city = 'TRIVANDRUM '  or
city = 'KANCHEEPURAM '  or
city = 'WARANGAL '  or
city = 'BOKARO '  or
city = 'VELLORE '  or
city = 'BURDWAN '  or
city = 'AJMER '  or
city = 'SOLAPUR '  or
city = 'BATHINDA '  or
city = 'KOTA '  or
city = 'ALWAR '  or
city = 'JUNAGADH '  or
city = 'PANIPAT '  or
city = 'ANKLESHWAR '  or
city = 'JALNA '  or
city = 'BELGAUM '  or
city = 'VIJAYAWADA '  or
city = 'VAPI '  or
city = 'KANNUR '  or
city = 'REWARI '  or
city = 'BAREILLY '  or
city = 'SILIGURI '  or
city = 'SINGAPORE '  or
city = 'SANGAMNER '  or
city = 'NORTH  PARGANAS '  or
city = 'KURNOOL '  or
city = 'TRICHY '  or
city = 'DHANBAD '  or
city = 'KOTTAYAM '  or
city = 'ROHTAK '  or
city = 'KARNAL '  or
city = 'BILASPUR '  or
city = 'MANGALORE '  or
city = 'KOZHIKODE '  or
city = 'DHULE '  or
city = 'ANAND '  or
city = 'CHITTOOR '  or
city = 'ALIGARH '  or
city = 'NAVSARI '  or
city = 'MEDAK '  or
city = 'KOCHI '  or
city = 'VALSAD '  or
city = 'MUZAFFARPUR '  or
city = 'NAMAKKAL '  or
city = 'ANANTAPUR '  or
city = 'DURGAPUR '  or
city = 'MEHSANA '  or
city = 'UJJAIN '  or
city = 'RATNAGIRI '  or
city = 'THANE WEST '  or
city = 'BHIWANI '  or
city = 'KHAMMAM '  or
city = 'KARAD '  or
city = 'BHILWARA '  or
city = 'PRAKASAM '  or
city = 'TIRUNELVELI '  or
city = 'LATUR '  or
city = 'UDUPI '  or
city = 'THIRUVANANTHAPURAM '  or
city = 'TIRUVALLUR '  or
city = 'GAYA '  or
city = 'SONIPAT '  or
city = 'NASIK '  or
city = 'KALYAN '  or
city = 'SOUTH DELHI '  or
city = 'KANPUR NAGAR '  or
city = 'SILVASSA '  or
city = 'AHMADNAGAR '  or
city = 'EAST GODAVARI '  or
city = 'PORBANDAR '  or
city = 'SHARJAH '  or
city = 'NORTH TWENTY FOUR PARGANAS '  or
city = 'MATHURA '  or
city = 'AMBALA '  or
city = 'HOSHIARPUR '  or
city = 'GULBARGA '  or
city = 'GANDHIDHAM '  or
city = 'WEST GODAVARI '  or
city = 'DURG '  or
city = 'SAHARANPUR '  or
city = 'SURENDRANAGAR '  or
city = 'MORADABAD '  or
city = 'K V RANGAREDDY '  or
city = 'TIRUCHIRAPPALLI '  or
city = 'NALGONDA '  or
city = 'BHAGALPUR '  or
city = 'SATNA '  or
city = 'SHIMLA '  or
city = 'NADIAD '  or
city = 'GAUTAM BUDDHA NAGAR '  or
city = 'CHANDIGARH U T '  or
city = 'MAHESANA '  or
city = 'THANJAVUR '  or
city = 'RANGAREDDI '  or
city = 'CUDDAPAH '  or
city = 'PALANPUR '  or
city = 'ROURKELA '  or
city = 'RAIGAD '  or
city = 'MALAPPURAM '  or
city = 'KURUKSHETRA '  or
city = 'MUZAFFARNAGAR '  or
city = 'ANGUL '  or
city = 'KANGRA '  or
city = 'KOLLAM '  or
city = 'PALGHAR '  or
city = 'BHILAI '  or
city = 'AHMADABAD '  or
city = 'HAMIRPUR '  or
city = 'VIZIANAGARAM '  or
city = 'DIST THANE '  or
city = 'SHILLONG '  or
city = 'SIRSA '  or
city = 'MANDI '  or
city = 'SRIKAKULAM '  or
city = 'CUDDALORE '  or
city = 'NANDED '  or
city = 'BHUJ '  or
city = 'DEOGHAR '  or
city = 'NIZAMABAD '  or
city = 'DINDIGUL '  or
city = 'TIRUPPUR '  or
city = 'BIKANER '  or
city = 'JORHAT '  or
city = 'PONDA '  or
city = 'HYDERABAD TELANGANA '  or
city = 'TIRUPATI '  or
city = 'AMRELI '  or
city = 'EAST DELHI '  or
city = 'MARGAO '  or
city = 'JHANSI '  or
city = 'DARBHANGA '  or
city = 'KAITHAL '  or
city = 'MORBI '  or
city = 'PONDICHERRY '  or
city = 'VIRUDHUNAGAR '  or
city = 'CHANDRAPUR '  or
city = 'HARIDWAR '  or
city = 'NAINITAL '  or
city = 'ALAPPUZHA '  or
city = 'DOHA '  or
city = 'KAKINADA '  or
city = 'ICHALKARANJI '  or
city = 'MOGA '  or
city = 'MUKTSAR '  or
city = 'KANCHIPURAM '  or
city = 'WARDHA '  or
city = 'BELLARY '  or
city = 'NORTH PARGANAS '  or
city = 'BULANDSHAHR '  or
city = 'PATHANAMTHITTA '  or
city = 'TRICHUR '  or
city = 'KHOPOLI '  or
city = 'KARUR '  or
city = 'RATLAM '  or
city = 'YAVATMAL '  or
city = 'RAMGARH '  or
city = 'SAGAR '  or
city = 'VERAVAL '  or
city = 'GURDASPUR '  or
city = 'BEGUSARAI '  or
city = 'RANGA REDDY '  or
city = 'ADILABAD '  or
city = 'KUWAIT '  or
city = 'MUSCAT '  or
city = 'KUSHINAGAR '  or
city = 'SIKAR '  or
city = 'DEORIA '  or
city = 'SOLAN '  or
city = 'UNNAO '  or
city = 'PARBHANI '  or
city = 'CHITTORGARH '  or
city = 'VILLUPURAM '  or
city = 'REWA '  or
city = 'KORBA '  or
city = 'PRATAPGARH '  or
city = 'PANVEL '  or
city = 'WEST DELHI '  or
city = 'KAPURTHALA '  or
city = 'TIRUPUR '  or
city = 'YAMUNA NAGAR '  or
city = 'ULHASNAGAR '  or
city = 'KALOL '  or
city = 'TINSUKIA '  or
city = 'HUBLI '  or
city = 'GANJAM '  or
city = 'NADIA '  or
city = 'PALI '  or
city = 'DAMAN '  or
city = 'FEROZEPUR '  or
city = 'BALLIA '  or
city = 'ASANSOL '  or
city = 'SOUTH WEST DELHI '  or
city = 'BANKURA '  or
city = 'YAMUNANAGAR '  or
city = 'JIND '  or
city = 'SANGRUR '  or
city = 'BEED '  or
city = 'KOPARGAON '  or
city = 'DIBRUGARH '  or
city = 'BHIWADI '  or
city = 'BARNALA '  or
city = 'JAUNPUR '  or
city = 'MANDSAUR '  or
city = 'BHUSAWAL '  or
city = 'PANAJI '  or
city = 'BIJNOR '  or
city = 'HALDWANI '  or
city = 'SOUTH  PARGANAS '  or
city = 'DHARMAPURI '  or
city = 'PATHANKOT '  or
city = 'JETPUR '  or
city = 'COCHIN '  or
city = 'KADAPA '  or
city = 'FATEHPUR '  or
city = 'DHARWAD '  or
city = 'RAJAHMUNDRY '  or
city = 'AZAMGARH '  or
city = 'SHIMOGA '  or
city = 'RAJPURA '  or
city = 'KATNI '  or
city = 'FIROZABAD '  or
city = 'MITHAPUR '  or
city = 'PATAN '  or
city = 'SAMBALPUR '  or
city = 'NEEMUCH '  or
city = 'DEESA '  or
city = 'RIYADH '  or
city = 'BARDEZ '  or
city = 'RAEBARELI '  or
city = 'GIRIDIH '  or
city = 'KRISHNAGIRI '  or
city = 'DEWAS '  or
city = 'BAHADURGARH '  or
city = 'BIDAR '  or
city = 'MAHABUBNAGAR '  or
city = 'BALASORE '  or
city = 'SIWAN '  or
city = 'PUDUCHERRY '  or
city = 'KALYANI '  or
city = 'SRIGANGANAGAR '  or
city = 'JALPAIGURI '  or
city = 'PALWAL '  or
city = 'UNA '  or
city = 'GOA '  or
city = 'AMBALA CANTT '  or
city = 'GHAZIPUR '  or
city = 'KHURDA '  or
city = 'ALIBAG '  or
city = 'THIRUVALLUR '  or
city = 'HIMATNAGAR '  or
city = 'GUNA '  or
city = 'UNJHA '  or
city = 'RAMPUR '  or
city = 'MANSA '  or
city = 'CALCUTTA '  or
city = 'BHARATPUR '  or
city = 'FAIZABAD '  or
city = 'TUMKUR '  or
city = 'SUNDARGARH '  or
city = 'MEDINIPUR '  or
city = 'JHAJJAR '  or
city = 'KARIM NAGAR '  or
city = 'VISNAGAR '  or
city = 'TALAJA '  or
city = 'KHARGONE '  or
city = 'NORTH WEST DELHI '  or
city = 'SAMASTIPUR '  or
city = 'MAPUSA '  or
city = 'TIRUVANNAMALAI '  or
city = 'PURI '  or
city = 'NEW PANVEL '  or
city = 'MAU '  or
city = 'HAZARIBAG '  or
city = 'FATEHABAD '  or
city = 'BOISAR '  or
city = 'MAHUVA '  or
city = 'DAKSHINA KANNADA '  or
city = 'KADI '  or
city = 'GOLAGHAT '  or
city = 'VIDISHA '  or
city = 'NAGAUR '  or
city = 'HAORA '  or
city = 'GONDAL '  or
city = 'VIJAPUR '  or
city = 'GANDHI NAGAR '  or
city = 'BULDHANA '  or
city = 'BERHAMPORE '  or
city = 'BHANDARA '  or
city = 'MADHUBANI '  or
city = 'DOMBIVALI '  or
city = 'SHAHDOL '  or
city = 'DHAR '  or
city = 'NARNAUL '  or
city = 'SOUTH TWENTY FOUR PARGANAS '  or
city = 'DOMBIVLI '  or
city = 'HAZARIBAGH '  or
city = 'SHRIRAMPUR '  or
city = 'NANDURBAR '  or
city = 'DAVANGERE '  or
city = 'AHMED NAGAR '  or
city = 'SITAPUR '  or
city = 'CHHINDWARA '  or
city = 'ZIRAKPUR '  or
city = 'KHANDWA '  or
city = 'THENI '  or
city = 'MUNDRA '  or
city = 'KANYAKUMARI '  or
city = 'GREATER NOIDA '  or
city = 'FARIDKOT '  or
city = 'ROORKEE '  or
city = 'DHENKANAL '  or
city = 'BASTI '  or
city = 'MUNGER '  or
city = 'MIRAJ '  or
city = 'MAHARAJGANJ '  or
city = 'HASSAN '  or
city = ' MUMBAI '  or
city = 'JHUNJHUNU '  or
city = 'WASHIM '  or
city = 'ADIPUR '  or
city = 'JHARSUGUDA '  or
city = 'PUDUKKOTTAI '  or
city = 'NALANDA '  or
city = 'BALAGHAT '  or
city = 'BHADRAK '  or
city = 'ETAWAH '  or
city = 'CALICUT '  or
city = 'VASCO '  or
city = 'BETUL '  or
city = 'HALDIA '  or
city = 'BULDANA '  or
city = 'BAGALKOT '  or
city = 'JAJPUR '  or
city = 'PUNE CITY PUNE '  or
city = 'CHHATARPUR '  or
city = 'DARJEELING '  or
city = 'DOMBIVALI EAST '  or
city = 'VAISHALI '  or
city = 'KEONJHAR '  or
city = 'AURAIYA '  or
city = 'PERAMBALUR '  or
city = 'HOSHANGABAD '  or
city = 'KENDRAPARA '  or
city = 'SULTANPUR '  or
city = 'HARDOI '  or
city = 'MIRZAPUR '  or
city = 'BANSWARA '  or
city = 'VASCO DA GAMA '  or
city = 'BARABANKI '  or
city = 'BALOTRA '  or
city = 'BEAWAR '  or
city = 'SIVASAGAR '  or
city = 'RUDRAPUR '  or
city = 'HARDA '  or
city = 'PALAMPUR '  or
city = 'OSMANABAD '  or
city = 'FAZILKA '  or
city = 'ROPAR '  or
city = 'NAGAPATTINAM '  or
city = 'HOSUR '  or
city = 'KANNIYAKUMARI '  or
city = 'THANE W '  or
city = 'KHEDA '  or
city = 'KOLAR '  or
city = 'SHIVPURI '  or
city = 'WAYANAD '  or
city = 'SONEPAT '  or
city = 'CHURU '  or
city = 'GODHRA '  or
city = 'BIJAPUR '  or
city = 'MAHENDRAGARH '  or
city = 'TARN TARAN '  or
city = 'SILCHAR '  or
city = 'BATALA '  or
city = 'GANGANAGAR '  or
city = 'ALMORA '  or
city = 'SHAHJAHANPUR '  or
city = 'RUPNAGAR '  or
city = 'BANDA '  or
city = 'SIVAGANGA '  or
city = 'KALKA '  or
city = 'RAMANATHAPURAM '  or
city = 'NAGDA '  or
city = 'KHAMBHAT '  or
city = 'PURULIA '  or
city = 'BARDDHAMAN '  or
city = 'AMBALA CITY '  or
city = 'IDAR '  or
city = 'CARANZALEM '  or
city = 'AMBIKAPUR '  or
city = 'SALCETE '  or
city = 'SOUTH PARGANAS '  or
city = 'ANANTNAG '  or
city = 'MANDYA '  or
city = 'NABHA '  or
city = 'PORVORIM '  or
city = 'BANGALORE NORTH '  or
city = 'LONDON '  or
city = 'HAJIPUR '  or
city = 'BANGLORE '  or
city = 'UDHAM SINGH NAGAR '  or
city = 'NAWANSHAHR '  or
city = 'SEHORE '  or
city = 'KOTHAGUDEM '  or
city = 'FARRUKHABAD '  or
city = 'TUTICORIN '  or
city = 'DAHOD '  or
city = 'DAUSA '  or
city = 'TIKAMGARH '  or
city = 'ABOHAR '  or
city = 'JAYSINGPUR '  or
city = 'DAHANU '  or
city = 'TEZPUR '  or
city = 'MORENA '  or
city = 'KULLU '  or
city = 'HATHRAS '  or
city = 'AGARTALA '  or
city = 'JHUNJHUNUN '  or
city = 'IDUKKI '  or
city = 'EGRA '  or
city = 'RAICHUR '  or
city = 'ONGOLE '  or
city = 'SINDHUDURG '  or
city = 'DWARKA '  or
city = 'BERHAMPUR '  or
city = 'BOTAD '  or
city = 'SITAMARHI '  or
city = 'RAJSAMAND '  or
city = 'HANUMANGARH '  or
city = 'AMBEDKAR NAGAR '  or
city = 'BHIWANDI '  or
city = 'PARGANAS '  or
city = 'TISWADI '  or
city = 'BURHANPUR '  or
city = 'ANJAR '  or
city = 'DHOLPUR '  or
city = 'RANIGANJ '  or
city = 'AMBERNATH '  or
city = 'HAPUR '  or
city = 'KHARAR '  or
city = 'BHADOHI '  or
city = 'KASHIPUR '  or
city = 'PHAGWARA '  or
city = 'BANKA '  or
city = 'DHURI '  or
city = 'BANGALORE NORTH BANGALORE '  or
city = 'JAGATSINGHPUR '  or
city = 'BARMER '  or
city = 'PHALTAN '  or
city = 'GAUTAM BUDH NAGAR '  or
city = 'TANUKU '  or
city = 'DHRANGADHRA '  or
city = 'LONAVALA '  or
city = 'UTTARA KANNADA '  or
city = 'THIRUVALLA '  or
city = 'MURSHIDABAD '  or
city = 'KODAGU '  or
city = 'KASARAGOD '  or
city = 'BUXAR '  or
city = 'SABARKANTHA '  or
city = 'PANJIM '  or
city = 'ABUDHABI '  or
city = 'THIRUVARUR '  or
city = 'SAFAT '  or
city = 'RAHATA '  or
city = 'HONG KONG '  or
city = 'KHANNA '  or
city = 'GOPALGANJ '  or
city = 'DALTONGANJ '  or
city = 'SIVAKASI '  or
city = 'RAHURI '  or
city = 'SEONI '  or
city = 'NAGAON '  or
city = 'DAUND '  or
city = 'SURENDRA NAGAR '  or
city = 'KHORDA '  or
city = 'SIROHI '  or
city = 'KOTKAPURA '  or
city = 'BAHRAICH '  or
city = 'JEDDAH '  or
city = 'THOOTHUKUDI '  or
city = 'ETAH '  or
city = 'EAST CHAMPARAN '  or
city = 'TALOD '  or
city = 'DATIA '  or
city = 'BADLAPUR '  or
city = 'KOVILPATTI '  or
city = 'BARGARH '  or
city = 'BANGALORE SOUTH  '  or
city = 'SHIRPUR '  or
city = 'PURNEA '  or
city = 'PUNE CITY '  or
city = 'RAJNANDGAON '  or
city = 'SARAN '  or
city = 'ITARSI '  or
city = 'MADHEPURA '  or
city = 'WEST CHAMPARAN '  or
city = 'BHUBANESHWAR '  or
city = 'NEW MUMBAI '  or
city = 'NAWADA '  or
city = 'MALOUT '  or
city = 'KHARAGPUR '  or
city = 'ROHTAS '  or
city = 'MALDA '  or
city = 'POLLACHI '  or
city = 'BANASKANTHA '  or
city = 'KHORDHA '  or
city = 'BICHOLIM '  or
city = 'HAVERI '  or
city = 'KALYAN WEST '  or
city = 'ISLAMPUR '  or
city = 'GANGTOK '  or
city = 'THOOTHUKKUDI '  or
city = 'MAINPURI '  or
city = 'DHARAMSHALA '  or
city = 'ANANTHAPUR '  or
city = 'HINGOLI '  or
city = 'SHAJAPUR '  or
city = 'THALASSERY '  or
city = 'JALAUN '  or
city = 'KUMBAKONAM '  or
city = 'SONBHADRA '  or
city = 'KANNAUJ '  or
city = 'MUMABI '  or
city = 'PURNIA '  or
city = 'PORBANDER '  or
city = 'HANSI '  or
city = 'SOUTH GOA '  or
city = 'ALUVA '  or
city = 'KUTCH '  or
city = 'BANGALORE SOUTH BANGALORE '  or
city = 'SIDHI '  or
city = 'NORTH GOA '  or
city = 'JAGRAON '  or
city = 'VIRAR WEST '  or
city = 'ARARIA '  or
city = 'HALVAD '  or
city = 'BANDIPORA '  or
city = 'SRI GANGANAGAR '  or
city = 'JAJAPUR '  or
city = 'CENTRAL DELHI '  or
city = 'THANGADH '  or
city = 'BORIVALI WEST MUMBAI '  or
city = 'CHERTHALA '  or
city = 'MANAMA '  or
city = 'DELHI NEW DELHI '  or
city = 'MODASA '  or
city = 'VASAI '  or
city = 'MAYURBHANJ '  or
city = 'KAMRUP '  or
city = 'BANGALURU '  or
city = 'BUNDI '  or
city = 'OMAN '  or
city = 'GONDA '  or
city = 'BARDOLI '  or
city = 'CHITRADURGA '  or
city = 'KHAMGAON '  or
city = 'PURBA MEDINIPUR '  or
city = 'MOTIHARI '  or
city = 'MAHABUB NAGAR '  or
city = 'DAMOH '  or
city = 'SHEOPUR '  or
city = 'BARDHAMAN '  or
city = 'GONDIA '  or
city = 'PASCHIM MEDINIPUR '  or
city = 'PAONTA SAHIB '  or
city = 'SAWANTWADI '  or
city = 'CHICALIM '  or
city = 'SHEGAON '  or
city = 'SAWAI MADHOPUR '  or
city = 'KHAMBHALIA '  or
city = 'CONTAI '  or
city = 'UDHAMPUR '  or
city = 'BHOJPUR '  or
city = 'SAHARSA '  or
city = 'CHANDIGARH UT '  or
city = 'BAHRAIN '  or
city = 'SAMBHAL '  or
city = 'CHANDAULI '  or
city = 'GODDA '  or
city = 'MANDI GOBINDGARH '  or
city = 'ALIPURDUAR '  or
city = 'BARAMATI '  or
city = 'MAHASAMUND '  or
city = 'EAST SINGHBHUM '  or
city = 'COOCHBEHAR '  or
city = ' PUNE '  or
city = 'MANDLA '  or
city = 'AMALNER '  or
city = 'VIJAYAWADA URBAN KRISHNA '  or
city = 'NAYAGARH '  or
city = 'MIDNAPORE '  or
city = 'COOCH BEHAR '  or
city = 'BIRBHUM '  or
city = 'AMROHA '  or
city = 'MANDVI '  or
city = 'KISHANGARH '  or
city = 'BAVLA '  or
city = 'FATORDA '  or
city = 'FATEHGARH SAHIB '  or
city = 'KHERI '  or
city = 'BALRAMPUR '  or
city = 'NAVI MUMBAI THANE '  or
city = 'SUTRAPADA '  or
city = 'RISHIKESH '  or
city = 'RAJGARH '  or
city = 'JATH '  or
city = 'BUDGAM '  or
city = 'BARAMULLA '  or
city = 'CHENGALPATTU '  or
city = 'JEHANABAD '  or
city = 'SEDAM '  or
city = 'ELURU '  or
city = 'KATHUA '  or
city = 'DUMKA '  or
city = 'NIMBAHERA '  or
city = 'JANJGIR CHAMPA '  or
city = 'DOMBIVLI EAST '  or
city = 'ASHOK NAGAR '  or
city = 'TAMLUK '  or
city = 'SANGAREDDY '  or
city = 'DUNGARPUR '  or
city = 'CHAPRA '  or
city = 'JAGDALPUR '  or
city = 'PILIBHIT '  or
city = ' THANE '  or
city = 'GONDIYA '  or
city = 'DHAMTARI '  or
city = 'NANGAL '  or
city = 'BARAN '  or
city = 'THODUPUZHA '  or
city = 'SAUDI ARABIA '  or
city = 'LAKHISARAI '  or
city = 'ARRAH '  or
city = 'KATIHAR '  or
city = 'DHORAJI '  or
city = 'SAVARKUNDLA '  or
city = 'ANUPPUR '  or
city = 'WANKANER '  or
city = 'MORVI '  or
city = 'DULIAJAN '  or
city = 'JAGADHRI '  or
city = 'UDUMALPET '  or
city = 'BAGHPAT '  or
city = 'GADAG '  or
city = 'SIRSI '  or
city = 'MANAVADAR '  or
city = 'BUDAUN '  or
city = 'CURCHOREM '  or
city = 'HINGANGHAT '  or
city = 'CHANGANACHERRY '  or
city = 'FORBESGANJ '  or
city = 'JAMUI '  or
city = 'CHATRA '  or
city = 'AUSTRALIA '  or
city = 'MANCHERIAL '  or
city = ' BANGALORE '  or
city = 'KARWAR '  or
city = 'BILIMORA '  or
city = 'DHOLKA '  or
city = 'THE NILGIRIS '  or
city = 'NILGIRIS '  or
city = 'DAMMAM '  or
city = 'NANI DAMAN '  or
city = 'KACHCHH '  or
city = 'PULWAMA '  or
city = 'NAVIMUMBAI '  or
city = 'NAGERCOIL '  or
city = 'BHIND '  or
city = 'KAPADWANJ '  or
city = 'SAS NAGAR '  or
city = 'HARYANA '  or
city = 'NAVELIM '  or
city = 'CHENGANNUR '  or
city = 'TONK '  or
city = 'SURAJPUR '  or
city = 'RAJAPALAYAM '  or
city = 'LOHARDAGA '  or
city = 'MUZAFFAR NAGAR '  or
city = 'GODAVARI '  or
city = 'BETTIAH '  or
city = 'JALORE '  or
city = 'VILUPPURAM '  or
city = 'KORIYA '  or
city = 'KHUNTI '  or
city = 'KORAPUT '  or
city = 'ARAKKONAM '  or
city = 'AUCKLAND '  or
city = 'BINA '  or
city = 'RAMPURHAT '  or
city = 'QATAR '  or
city = 'LIMBDI '  or
city = 'BARSHI '  or
city = 'NORTH EAST DELHI '  or
city = 'NAIROBI '  or
city = 'MALKAPUR '  or
city = 'RANAGHAT '  or
city = 'PETLAD '  or
city = 'SIRHIND '  or
city = 'KENDUJHAR '  or
city = 'PINJORE '  or
city = 'SONITPUR '  or
city = 'SINGRAULI '  or
city = 'DIST RAIGAD '  or
city = 'KESHOD '  or
city = 'SINGHBHUM '  or
city = 'NARSINGHPUR '  or
city = 'JHAJHA '  or
city = 'SHAMLI '  or
city = 'CHIKKABALLAPUR '  or
city = 'NAVASARI '  or
city = 'CHIKMAGALUR '  or
city = 'CHAMPA '  or
city = 'BORSAD '  or
city = 'DHAMPUR '  or
city = 'RUWI '  or
city = 'VISHAKAPATNAM '  or
city = 'QUEPEM '  or
city = 'KARAIKUDI '  or
city = 'JAMALPUR '  or
city = 'KHARGHAR '  or
city = 'GARHWA '  or
city = 'BARPETA '  or
city = 'SECUNDERABAD HYDERABAD '  or
city = 'HABRA '  or
city = 'BENGALOORU '  or
city = 'CALANGUTE '  or
city = 'PALAMU '  or
city = 'DEHGAM '  or
city = 'LAKHIMPUR '  or
city = 'SHIRUR '  or
city = 'BANGALORE RURAL '  or
city = 'BALODA BAZAR '  or
city = 'KARAIKAL '  or
city = 'CHAKRADHARPUR '  or
city = 'FIROZPUR '  or
city = 'BIHARSHARIF '  or
city = 'CHAMBA '  or
city = 'TIRUVARUR '  or
city = 'RANIA '  or
city = 'BENGALORE '  or
city = 'TIRUPATHI '  or
city = 'KARIMGANJ '  or
city = 'KOLKATTA '  or
city = 'ASHTA '  or
city = 'WADHWAN '  or
city = 'PUSAD '  or
city = 'HALOL '  or
city = 'JHALAWAR '  or
city = 'UNITED KINGDOM '  or
city = 'BAKROL '  or
city = 'LUNAWADA '  or
city = 'MOHOPADA '  or
city = 'KICHHA '  or
city = 'BEMETARA '  or
city = 'GADHINGLAJ '  or
city = 'CHIPLUN '  or
city = 'VERNA '  or
city = 'AKOLE '  or
city = 'KRISHNANAGAR '  or
city = 'MAYILADUTHURAI '  or
city = 'AJMAN '  or
city = 'ROHA '  or
city = 'KHAGARIA '  or
city = 'DAVANAGERE '  or
city = 'BHIMAVARAM '  or
city = 'UMBERGAON '  or
city = 'AL KHOBAR  '  or
city = 'MUVATTUPUZHA '  or
city = 'BAGHA PURANA '  or
city = 'BALASINOR '  or
city = 'SUNAM '  or
city = 'PAURI GARHWAL '  or
city = 'PARADEEP '  or
city = 'JALALABAD '  or
city = 'VIRAR '  or
city = 'SUNDERGARH '  or
city = 'GUMLA '  or
city = 'DABOLIM '  or
city = 'SHAHAPUR '  or
city = 'LAKHIMPUR KHERI '  or
city = 'JAORA '  or
city = 'MADHUPUR '  or
city = 'KODINAR '  or
city = 'CHICKMAGALUR '  or
city = 'R R DIST '  or
city = 'RAJULA '  or
city = 'KARJAT '  or
city = 'BALLARPUR '  or
city = 'TIRUCHIRAPALLI '  or
city = 'KOPPAL '  or
city = 'BANGKOK '  or
city = 'NALBARI '  or
city = 'DIGBOI '  or
city = 'ARIYALUR '  or
city = 'MUMBAI SUB URBAN '  or
city = 'ROHINI '  or
city = 'MALERKOTLA '  or
city = 'TENKASI '  or
city = 'BHACHAU '  or
city = 'PRANTIJ '  or
city = 'ORAI '  or
city = 'RAJAHMUNDRI '  or
city = 'SIDHPUR '  or
city = 'TENALI GUNTUR '  or
city = 'SAINTHIA '  or
city = 'PGS N '  or
city = 'ARVI '  or
city = 'BIAORA '  or
city = 'IMPHAL '  or
city = 'VIZAG '  or
city = 'PACHORA '  or
city = 'LALITPUR '  or
city = 'AKOT '  or
city = 'VIJAYWADA '  or
city = 'BOLANGIR '  or
city = 'SUPAUL '  or
city = 'MAVELIKARA '  or
city = 'MAHOBA '  or
city = 'DHARAMPUR '  or
city = 'NAMAKKAL DT '  or
city = 'GURGOAN '  or
city = 'RAJGANGPUR '  or
city = 'THANA '  or
city = 'RAJGIR '  or
city = 'BARBIL '  or
city = 'TALEIGAO '  or
city = 'SOPORE '  or
city = 'SAHEBGANJ '  or
city = 'JAMNER '  or
city = 'PANNA '  or
city = 'EAST SINGBHUM '  or
city = 'AKHNOOR '  or
city = 'SIDDHARTHNAGAR '  or
city = 'KODERMA '  or
city = 'BALANGIR '  or
city = 'SHAHPURA '  or
city = 'PITHORAGARH '  or
city = 'MALEGAON '  or
city = 'PRODDATUR '  or
city = 'BONGAIGAON '  or
city = 'KALIYAGANJ '  or
city = 'SIVAGANGAI '  or
city = 'PEN '  or
city = 'DAMANJODI '  or
city = 'KARAULI '  or
city = 'KANCHRAPARA '  or
city = 'SOUTH DELHI DELHI '  or
city = 'BHADRACHALAM '  or
city = 'NORTH WEST DELHI DELHI '  or
city = 'MAIHAR '  or
city = 'PARDI '  or
city = 'PALITANA '  or
city = 'TIRUCHENGODE '  or
city = 'SANGALI '  or
city = 'NORTH DELHI '  or
city = 'BOKARO STEEL CITY '  or
city = 'CHIDAMBARAM '  or
city = 'NAKODAR '  or
city = 'JHABUA '  or
city = 'CUNCOLIM '  or
city = 'VITA '  or
city = 'CANDOLIM '  or
city = 'KUDAL '  or
city = 'SURYAPET '  or
city = 'KANDIVALI EAST MUMBAI '  or
city = 'GOBICHETTIPALAYAM '  or
city = 'MACHILIPATNAM '  or
city = 'DINHATA '  or
city = 'KALYAN THANE '  or
city = 'SIRMAUR '  or
city = 'SHIVAMOGGA '  or
city = 'KANKAVLI '  or
city = 'KOTHAMANGALAM '  or
city = 'DOMBIVALI WEST '  or
city = 'RAISEN '  or
city = 'DABRA '  or
city = 'BANTWAL '  or
city = 'SHAHADA '  or
city = 'TENALI '  or
city = 'RAJOURI '  or
city = 'JAGATSINGHAPUR '  or
city = 'MANDIGOBINDGARH '  or
city = 'CHOPDA '  or
city = 'TIRUPATTUR '  or
city = 'RAYAGADA '  or
city = 'PERNEM '  or
city = 'MUNGELI '  or
city = 'DEVANGERE '  or
city = 'CHITRAKOOT '  or
city = 'AMETHI '  or
city = 'DIMAPUR '  or
city = 'KALAHANDI '  or
city = 'JODA '  or
city = 'CHANDANNAGAR '  or
city = 'MEWAT '  or
city = 'THANE EAST '  or
city = 'BOLPUR '  or
city = 'AMBARNATH '  or
city = 'HARDWAR '  or
city = 'CHALISGAON '  or
city = 'MADHAPAR '  or
city = 'UJHANI '  or
city = 'VISHAKHAPATNAM '  or
city = 'SHIKOHABAD '  or
city = 'CANACONA '  or
city = 'MIDNAPUR '  or
city = 'PIPARIYA '  or
city = 'PANDHARPUR '  or
city = 'SANT RAVIDAS NAGAR '  or
city = 'JHARKHAND '  or
city = 'HINDUPUR '  or
city = 'NARSIMHAPUR '  or
city = 'SYDNEY '  
 group by City,Profile_Flg
 order by count(distinct(cust_ID)) desc

 
----------------------------------------------------------------------------------------
-- Analysis on ##mf_distinct_Cust Count. 
-- We will be creating Pie Chart for MF Customer base with Tagging in traded product. 

select * from ##mf_distinct_cust
select Count(distinct(ENT_ID)) from ##mf_distinct_cust -- 180698

select top 1000 * from FINAL_Customer_One_View

-- left Join on ##MF_Distinct_Cust and FINAL_Customer_One_View
select a.ENT_ID,a.MF_FLG,b.CUST_ID,b.Traded_Product into ##MF_PIE_Data
from ##mf_distinct_cust a left join FINAL_Customer_One_View b 
on a.ENT_ID = b.CUST_ID
-- (180698 row(s) affected)

select top 100 * from ##MF_PIE_Data

-- Adding New column to ##MF_PIE_DATA for Tagging Traded_Product 
alter table ##MF_PIE_DATA 
add Tag varchar(20)

update ##MF_PIE_Data
set Tag = 
	case 
		when Traded_Product = 'Only_Delivery' then 'Only_Delivery'
		when Traded_Product = 'Only_Margin' then 'Only_Margin'
		when Traded_Product = 'Only_FUT' then 'Only_FUT'
		when Traded_Product = 'Only_OPT' then 'Only_OPT'
		when Traded_Product = 'Del_Mar' then 'Del_Mar'
		when Traded_Product is null and CUST_ID is null  then 'Only_MF'
		else 'Others'
	end
-- (180698 row(s) affected)

select * from ##MF_PIE_Data where Cust_ID is null

-- Count Tag
select Tag,count(distinct(ENT_ID)) as 'Count' 
from ##MF_PIE_Data 
group by Tag
order by count(distinct(ENT_ID)) desc
/*
Tag				Count
Only_Delivery	116500
Only_MF			36419
Del_Mar			11884
Only_Margin		8666
Others			6985
Only_OPT		199
Only_FUT		45
*/
		