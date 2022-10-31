*1;
libname lect "/home/u48583412/Biostat 203A/Assignment5";

data best_countries;
 set lect.best_countries;
run;

proc format;
 value hifmt 0-<50    = "< 50"
             50-75    = "50-75"
             75<-high = "> 75";
run;

proc freq data=best_countries order=freq;
 table region / nocol norow;
 where incGroup = "High";
run;

*2;
*2-1;
proc freq data=best_countries;
 table region*incGroup / nocol nocum nopercent;
 run;
 
*2-2;
proc printto log='/home/u48583412/Biostat 203A/Assignment5/q2.log';
run;

proc freq data=best_countries;
 table region*incGroup / nocol nocum nopercent Chisq;
 run;

proc freq data=best_countries;
 table region*incGroup / nocol nocum nopercent Fisher;
 run;
 
*2-3;
proc freq data=best_countries order=formatted;
 table popGroup*region*HI /nopercent nocum list;
 format HI hifmt.;
 run;

*3;
data cms_providers_la;
 set lect.cms_providers_la;
run;

%Macro Select(Sortvar);
proc means data=cms_providers_la n mean;
 class provider_type;
 var &Sortvar;
 output out=cms_means;
 run;
proc print data=cms_means;
 run;
%Mend Select;
%select(total_medicare_payment_amt);

*4;
data baseball;
 set sashelp.baseball;
run;

proc sql noprint;
  create table homers as
  select Name, Team, nHome, League, Salary
  from baseball
  where league="American" & nHome ge 30;
quit;

proc print data=homers;
run;


*5;
proc print data=lect.left; title "Left Data Set"; run;
proc print data=lect.right; title "Right Data Set";

proc sql;
 create table Both as
 select left.subj, right.subj, Height, Salary
 from lect.left as x left join lect.right as y
 on left.subj=right.subj;
quit;

proc print data=both noobs;
 title "Both Data Set";
run;
