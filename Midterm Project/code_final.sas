*/import data;
FILENAME REFFILE '/home/u59585996/Biostat203A/Midterm/HFLCAA01_1.csv';


PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT1;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT1; RUN;

proc print data=WORK.IMPORT1 (obs=100);
run;

*/format data;
proc format;
value $AOTU  0.10- <1.00 = "less than one pack "
             1.00- <2.00 = "between one and two packs "
             2.00- <3.00 = "between two and three packs "
             3.00- <4.00 = "between three and four packs  "
             4.00 = "over four packs  "
             97.00 = "the worker did smoke rarely but the amount could not be determined"
             98.00 = "no medical exam taken yet "
             99.00 = "either the worker did not smoke, or the amount could not be determined";
value $CCF   0 = "the worker was not a lung cancer case who was also selected as a control"
             1 = "the worker was a lung cancer case who was also selected as a control";
value $CF    0 = "the worker was not selected as a lung cancer case "
             1 = "the worker was selected as a lung cancer case ";
value $GJC   1 = "white collar"
             2 = "nuclear "
             3 = "craftsmen "
             4 = "service and other workers "
             8 = "no medical exam taken yet ";
value $RAOTU 0.05- <1.00 = "Less than one pack a day"
             1.00- <2.00 = "between one and two packs a day"
             2.00- <3.00 = "between two and three packs a day"
             3.00- <4.00 = "between three and four packs a day"
             4.00 = "over four packs a day"
             97.00 = "the worker did smoke rarely but the amount could not be determined"
             98.00 = "no medical exam taken yet "
             99.00 = "either the worker did not smoke, or the amount could not be determined";           
value $RTUS  0 = "selection of Never smoked category "
             1 = "selection of Smoking now category "
             2 = "selection of Used to smoke category "
             3 = "yes response to Do you smoke "
             4 = "no response to Do you smoke "
             5 = "yes response to Tobacco use "
             6 = "no response to Tobacco use "
             8 = "no medical exam data available yet"
             9 = "missing data ";
*value $RYQTU 98 = "no medical exam data available yet";
*             99 = "not applicable ";
value $TEF   0 = "the amount of tobacco use was not estimated "
             1 = "the amount of tobacco use was estimated "
             8 = "no medical exam taken yet ";
value $TUS   0 = "selection of Never smoked category "
             1 = "selection of Smoking now category "
             2 = "selection of Used to smoke category "
             3 = "yes response to Do you smoke "
             4 = "no response to Do you smoke "
             5 = "yes response to Tobacco use "
             6 = "no response to Tobacco use "
             8 = "no medical exam data available yet"
             9 = "missing data ";
value $TUT   0 = "examiner notation regarding the use of tobacco"
             1 = "yes response to Smoke cigarettes"
             2 = "yes response to Smoke cigars"
             3 = "yes respnse to Smoke a pipe"
             4 = "no response to each above inquiry "
             5 = "yes response to Chew tobacco "
             6 = "no tobacco type inquiry "
             7 = "yes response to Smoke cigarettes plus Smoke cigars and/or Smoke a pipe "
             8 = "no medical exam taken yet "
             9 = "missing data ";
run;


data HFLCAA;
set WORK.IMPORT1;
informat 
ceridnum 8.0
craexpl2 4.
crexpl10 4.
cumraexp 4.
fsyr2ubm 2.0
lsyr2ubm 2.0
nubm4451 2.0
nubm5264 2.0
nubm6575 2.0
nuby4451 1.0
nuby5264 1.0
nuby6575 1.0
seq_no 8.0
yrbegtob 2.0
yrbirth 2.0
yrdeath 2.0
yrfinmex 2.0
yrfollup 2.0
yrfraexp 2.0
yrmremex 2.0
yrquitob 2.0
yrreamt 2.0
yrretobs 2.0;
format 
ceridnum 8.0
craexpl2 4.
crexpl10 4.
cumraexp 4.
fsyr2ubm 2.0
lsyr2ubm 2.0
nubm4451 2.0
nubm5264 2.0
nubm6575 2.0
nuby4451 1.0
nuby5264 1.0
nuby6575 1.0
seq_no 8.0
yrbegtob 2.0
yrbirth 2.0
yrdeath 2.0
yrfinmex 2.0
yrfollup 2.0
yrfraexp 2.0
yrmremex 2.0
yrquitob 2.0
yrreamt 2.0
yrretobs 2.0;

format 
cacoflag $CCF.
caseflag $CF.
genjobca $GJC.
reamttob $RAOTU.
retobust $RTUS.
tobestfl $TEF.
tobustat $TUS.
tobustyp $TUT.;
label 
amtobuse = 'Amount of Tobacco Use'
bocjobca = 'Bureau of Census Job Category'
cacoflag = 'Case Control Flag'
caseflag = 'Case Flag'
ceridnum = 'Center for Epidemiologic Research ID #'
craexpl2 = 'Cumltv Radiation Exposure Lagged 2 Yrs'
crexpl10 = 'Cumltv Radiation Exposure Lagged 10 Yrs'
cumraexp = 'Cumulative Radiation Exposure'
fsyr2ubm = 'First Yr w/ 2+ Uranium Bioassay Measmts'
genjobca = 'General Job Category'
lsyr2ubm = 'Last Yr before 1965 w/ 2+ U.B. Measmnts'
nubm4451 = 'Num of U.B. Meassmnts 1944-1951'
nubm5264 = 'Num of U.B. Meassmnts 1952-1964'
nubm6575 = 'Num of U.B. Meassmnts 1965-1975'
nuby4451 = 'Num of Uranium Bioassay Yrs 1944-1951'
nuby5264 = 'Num of Uranium Bioassay Yrs 1952-1964'
nuby6575 = 'Num of Uranium Bioassay Yrs 1965-1975'
reamttob = 'Refined Amount of Tobacco Use'
retobust = 'Refined Tobacco Use Status'
reyrquit = 'Refined Year Quit Tobacco Use'
seq_no = 'sequence number of row'
titlejob = 'Title For Job Held Longest'
tobestfl = 'Tobacco Estimation Flag'
tobustat = 'Tobacco Use Status'
tobustyp = 'Tobacco Use Type'
yrbegtob = 'Year Began Tobacco Use'
yrbirth = 'Year of Birth'
yrdeath = 'Year of Death'
yrfinmex = 'Year of Final Medical Exam'
yrfollup = 'Year of Follow-up'
yrfraexp = 'Year of Final Radiation Exposure'
yrmremex = 'Year of Most Recent Medical Exam'
yrquitob = 'Year Quit Tobacco Use'
yrreamt = 'Year of Refined Amount of Tobacco Use'
yrretobs = 'Year of Refined Tobacco Use Status';
run;

PROC CONTENTS DATA=HFLCAA; RUN;

*/Adjust job;
data HFLCAA_2;
set HFLCAA;
 if substr(titlejob,1,1) in ("1") then job = 'white collar';
 else if substr(titlejob,1,1) in ("2") then job = 'nuclear';
 else if substr(titlejob,1,1) in ("3") then job = 'craftsmen';
 else if substr(titlejob,1,1) in ("4") then job = 'service and other workers';
 else if substr(titlejob,1,1) in ("8") then job = 'no medical exam taken yet';
 
 if yrdeath <=80 and yrbirth ~= 98 then age = (yrdeath - yrbirth);
 else if (yrdeath = 99) or (yrdeath >80 and yrdeath ~=98) then age = (80-yrbirth);
run;

*/Adjust cumulative radiaiton;
data HFLCAA_3;
 set HFLCAA_2;
 cumuradiation_chr = put(cumuradiation, 8.2);
 drop cumuradiation;
 rename cumuradiation_chr=cumuradiation;
 run;

data HFLCAA_3;
set HFLCAA_3;
 if 0 <= cumraexp and cumraexp <= 19.9 then cumuradiation = "0-20";
 else if 20 <= cumraexp and cumraexp <= 49.9 then cumuradiation = "20-50";
 else if 50 <= cumraexp and cumraexp <= 149.9 then cumuradiation = "50-150";
 else if 150 <= cumraexp then cumuradiation = ">150";
run;

*/Adjust pack year;
data HFLCAA_4;
set HFLCAA_3;
 if amtobuse = 97 then delete;
 else if amtobuse = 98 then delete;
 else if amtobuse = 99 then amtobuse = 0;
 if yrbegtob = 98 then delete;
 else if yrbegtob = 99 then yrbegtob = 0;
 if yrquitob = 98 then delete;
 else if yrquitob = 99 then yrquitob = 0;
 if yrbegtob = 0 and yrquitob = 0 then year_smoke = 0;
 else if yrbegtob = 0 and yrquitob ~=. then year_smoke = yrquitob - (yrbirth+18);
 else if yrbegtob ~=. and yrquitob = 0 then year_smoke = 80 - yrbegtob;
 else if yrbegtob ~=. and yrquitob ~=. then year_smoke = yrquitob - yrbegtob;
 pack_year = amtobuse*year_smoke;
run;

*/last observation in a group;
data HFLCAA_5;
set HFLCAA_4;
by ceridnum notsorted;
if last.ceridnum;
run;

*/pack_year_group;
data HFLCAA_6;
set HFLCAA_5;
 if pack_year = 0 then pack_year_range = 0;
 else if 0 < pack_year and pack_year <= 20 then pack_year_range = 1;
 else if 20 < pack_year and pack_year <= 40 then pack_year_range = 2;
 else if 40 < pack_year and pack_year <= 60 then pack_year_range = 3;
 else if 60 < pack_year then pack_year_range = 4;
run;

*/pack_year*smoking;
proc freq data = HFLCAA_6 order = internal;
table pack_year_range*caseflag/nocum nocol norow ;
run;

*/Relative Risk1;
data smoking_casecontrol;
  input Case $ Pack $ Count;
  datalines;
    Yes No 31
    No  No 142
    Yes one 14
    No  one 81
; 
proc freq order=data data=smoking_casecontrol;
  weight Count;
  tables Case*Pack / riskdiff relrisk;
run;

*/radiation;
proc freq data = HFLCAA_6 order = internal;
table cumuradiation*caseflag/nocum;
run;

*/job*case;
proc freq data = HFLCAA_6 order = data;
table job*caseflag/nocum ;
run;

*/job*smoking;
proc freq data = HFLCAA_6 order = internal;
table job*pack_year_range/nocum ;
run;

*/job*radiation;
proc freq data = HFLCAA_6 order = internal;
table job*cumuradiation/nocum ;
run;


*/logistic regression for smoking;
data HFLCAA_7;
 set HFLCAA_5;
 pack_year_range_chr = put(pack_year_range, 8.2);
 drop pack_year_range;
 rename pack_year_range_chr=pack_year_range;
 run;

data HFLCAA_7;
set HFLCAA_7;
 if pack_year = 0 then pack_year_range = "0";
 else if 0 < pack_year and pack_year <= 20 then pack_year_range = "0-20";
 else if 20 < pack_year and pack_year <= 40 then pack_year_range = "20-40";
 else if 40 < pack_year and pack_year <= 60 then pack_year_range = "40-60";
 else if 60 < pack_year then pack_year_range = ">60";
run;

proc logistic data=HFLCAA_7 plots=effect;
   model caseflag(event="the worker was selected as a lung cancer case") = pack_year;
   output out=LogiOut_smoking predicted=PredProb;
   effectplot fit /obs ;
run;

*/logistic regression for radiation;
data HFLCAA_8;
 set HFLCAA_7;
 cumraexp_num = input(cumraexp, 4.);
 drop cumraexp;
 rename cumraexp_num=cumraexp;
 run;
 
PROC CONTENTS DATA=HFLCAA_8; RUN;

proc logistic data=HFLCAA_8 plots=effect;
   model caseflag(event="the worker was selected as a lung cancer case") = cumraexp;
   output out=LogiOut_radiation predicted=PredProb;
   effectplot fit /obs;
   run;

*/histogram supplemental;
Proc sgplot data= HFLCAA_7 pctlevel = group;
vbar pack_year_range/group=caseflag groupdisplay=cluster stat=percent datalabel;
label pack_year_range= "Total Amount of Tobacco Use";
title "Histogram of Smoking Exposure and Lung Cancer Cases";
run;

Proc sgplot data= HFLCAA_6 pctlevel = group;
vbar cumuradiation/group=caseflag groupdisplay=cluster stat=percent datalabel;
label cumuradiation= "Total Amount of Radiation Exposure";
title "Histogram of Radiation Exposure and Lung Cancer Cases";
run;

*/Age table;
Data Age;
	set HFLCAA_2;
	by ceridnum notsorted;
	keep ceridnum yrdeath yrbirth age caseflag agegroup;
    if last.ceridnum;
		if age <60 then agegroup = 'Age<60';
		else if age >= 60 and age < 65 then agegroup = "60<=Age<65";
		else if age >= 65 and age < 70 then agegroup = "65<=Age<70";
		else if age >= 70 and age < 75 then agegroup = "70<=Age<75";
		else if age >= 75 and age <= 80 then agegroup = '75<=Age<=80';
		else agegroup = .;
RUN;

/*Double checking the data selection outcome*/
PROC PRINT data = Age;
	where agegroup =".";
RUN;

proc freq data = Age;
	table agegroup;
RUN;

/* Generate table for age and caseflag */
proc freq data = Age;
table agegroup*caseflag/nocum nopercent;
run;

