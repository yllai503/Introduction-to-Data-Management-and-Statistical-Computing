*Exercise 1;
*a;
libname xptfile0 XPORT "/home/u48583412/Biostat 203A/Assignment4/XPT/TR.xpt";
libname ino "/home/u48583412/Biostat 203A/Assignment4/XPTread";
proc copy in=xptfile0 out=ino memtype=data;
run;

proc contents data=ino.IC order=varnum;
run;
proc print data=ino.IC (firstobs=1 obs=5);
run;

proc contents data=ino.RS order=varnum;
run;
proc print data=ino.RS (firstobs=1 obs=5);
run;

proc contents data=ino.TR order=varnum;
run;
proc print data=ino.TR (firstobs=1 obs=5);
run;

proc contents data=ino.TU order=varnum;
run;
proc print data=ino.TU (firstobs=1 obs=5);
run;

*b;
proc sort  data=ino.TR ;
by  SUBJIDN TRDTC VISIT TREVALID;
run; 
proc sort  data=ino.RS ;
by  SUBJIDN RSDTC VISIT RSEVALID;
run; 

data ino.TRRS;
merge ino.TR (rename = (TRDTC =DTC TREVALID=EVALID))
      ino.RS (rename = (RSDTC =DTC RSEVALID=EVALID));
by  SUBJIDN DTC VISIT EVALID;
run;

data ino.TRRS2;
	set ino.TRRS;
	if TRSEQ~=. & RSSEQ~=. then  merge=3;
	if TRSEQ=. & RSSEQ~=. then  merge=2;
	if TRSEQ~=. & RSSEQ=. then  merge=1;
run;

proc freq data=ino.TRRS2;
table merge;
run;

proc freq data=ino.TRRS2;
where merge=1;
table VISITNUM /nopercent nocol norow nocum ;
run;

proc freq data=ino.TRRS2;
where merge=2;
table RSORRES/nopercent nocol norow nocum;
table SUBJIDN/nopercent nocol norow nocum;
run;

*c;
data ino.TRRS3; 
	set ino.TRRS2; 
	by SUBJIDN VISITNUM; 
	if (first.SUBJIDN=1 or first.VISITNUM=1)  then output ;    
run; 

proc freq data=ino.TRRS3;
table SUBJIDN VISITNUM;
run;

proc freq data=ino.TRRS3 ;
table merge*VISITNUM/nopercent nocol norow nocum;
run;

*d;
data ino.TR1;
set ino.TR;
 TRSTRESC1 = input(TRSTRESC, 8.0);
run;

ods listing file="/home/u48583412/Biostat 203A/Assignment4/assn4.lst";
ods rtf file="/home/u48583412/Biostat 203A/Assignment4/assn4.rtf";
title1 "Baseline Target Disease Burden";
proc means data=ino.TR1 n mean std;
where TRTEST="Sum of Diameter" & TRACPTFL="Y" & VISIT="Screening";
class TRTEST TRACPTFL VISIT;
var TRSTRESC1;
run;
ods rtf close;
ods listing close;


PROC tabulate DATA = ino.tr1;
where trtest = "Sum of Diameter" AND tracptfl = "Y" AND visit = "Screening";
CLASS trtest tracptfl visit;
var trstresn;
TABLE trtest*tracptfl*visit,
trstresn = "trstresn"*(n*f=5. mean*f=5.2 std*f = 5.2);
RUN;
