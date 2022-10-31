*Exercise 1;
libname CEDR "/home/u48583412/Biostat 203A/Assignment2";
run;

PROC IMPORT OUT= CEDR.MDFACW
            DATAFILE= "/home/u48583412/Biostat 203A/Assignment2/MDFACW02_d1.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data CEDR.MDFACW (label="Working personnel file for Mound Plant");
  	informat orauid $8.;
  	informat bdate mmddyy10.;
  	informat sex 3.0;
  	informat educ 3.0;
  	informat hiredate mmddyy10.;
  	informat termdate mmddyy10.;
  	informat ddate mmddyy10.;
  	informat icda8 $8.;
  	informat autopsy 8.0;
  	informat dsex 4.0;
  	informat drace $8.;
  	informat dcity $40.;
  	informat dstate $8.;
  	informat dcounty $20.;
  	informat race $8.;
  	informat dmvflag $4.;
  	informat dmvdate mmddyy8.;
  	informat cvs $20.;
  	informat ssa861 $20.;
  	informat dla mmddyy10.;
 	informat seq_no 8.0;
 	infile "/home/u48583412/Biostat 203A/Assignment2/MDFACW02_d1.csv"  DSD firstobs=2;
 	input orauid$ bdate sex educ hiredate termdate ddate icda8$ autopsy dsex drace$ dcity$ 
 	      dstate$ dcounty$ race$ dmvflag$ dmvdate cvs$ ssa861$ dla seq_no;
 	format bdate DATE9.
           hiredate DATE9.
           termdate DATE9.
           ddate DATE9.
           dmvdate DATE9.
           dla DATE9.;
    label autopsy =	"Autopsy"
          bdate = "Date of birth"
          cvs = "Vital status EOS 1983"
          dcity = "The city of death"
          dcounty = "The county of death"
          ddate = "Date of death"
          dla = "Date last alive"
          dmvdate = "Activity date returned by DMV"
          dmvflag = "Submitted to Ohio DMV in 1988"
          drace = "Race on death certificate"
          dsex = "Sex on death certificate"
          dstate = "The state of death"
          educ = "Education"
          hiredate = "Date of first hire at Mound"
          icda8 = "Cause of death - ICDA 8th revision"
          orauid = "Oak Ridge assigned id number"
          race = "Race of worker"
          seq_no = "Sequence Number of Row"
          sex = "Sex"
          ssa861 = "Results of a 1986 SSA submission"
          termdate = "Date of last termination from Mound";
run; 
proc means data=CEDR.MDFACW   ;
run;
proc print data=CEDR.MDFACW (obs=5) label;
run;

*Exercise 2;
proc means data=CEDR.MDFACW n mean stddev median min max;
vars ddate dla seq_no;
run;

*Exercise 3;
proc format;
value education 1 = "Grade school"
                2 = "Some high school"
                3 = "High school graduate"
                4 = "Associates Degree"
                5 = "College Graduate"
                6 = "Advanced Degree"
                9 = "Unknown";
run;
proc freq data=CEDR.MDFACW ;
format educ education.;
tables educ /nocum;
run;

*Exercise 4;
proc format;
value $death "A" = "Alive"
            "D" = "Dead"
            "U" = "Unknown";
run;
proc freq data=CEDR.MDFACW;
format educ education.
       cvs $death.;
tables educ*cvs /nocum norow nocol;
run;

*Exercise 5;
data CEDR.MDFACW1;
set CEDR.MDFACW;
age = (hiredate-bdate)/365;
label age = "Age at first hired at Mound";
if age <0 then age =".";
run;

proc means data = CEDR.MDFACW1 n mean std median min max nonobs maxdec = 3;
var age;
format educ education.;
class educ;
run;


*Exercise 6;
libname CEDR "/home/u48583412/Biostat 203A/Assignment2";
run;
PROC IMPORT OUT= CEDR.MDFACW6
            DATAFILE= "/home/u48583412/Biostat 203A/Assignment2/MDFACW02_d1.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data CEDR.MDFACW6 (label="Working personnel file for Mound Plant");
  	informat orauid $8.
  	         bdate mmddyy10.
  	         sex $8.
  	         educ 3.0
  	         hiredate mmddyy10.
  	         termdate mmddyy10.
  	         ddate mmddyy10.
  	         icda8 $8.
          	 autopsy $8.
  	         dsex $8.c
          	 drace $8.
          	 dcity $40.
          	 dstate $8.
          	 dcounty $20.
          	 race $8.
          	 dmvflag $4.
          	 dmvdate mmddyy8.
          	 cvs $20.
          	 ssa861 $20.
          	 dla mmddyy10.
         	 seq_no 8.0;
 	infile "/home/u48583412/Biostat 203A/Assignment2/MDFACW02_d1.csv"  DSD firstobs=2;
 	input orauid$ bdate sex$ educ hiredate termdate ddate icda8$ autopsy$ dsex$ drace$ dcity$ 
 	      dstate$ dcounty$ race$ dmvflag$ dmvdate cvs$ ssa861$ dla seq_no;
 	format orauid $8.
 	       bdate DATE9.
 	       sex $8.
  	       educ 3.0
           hiredate DATE9.
           termdate DATE9.
           ddate DATE9.
           icda8 $8.
           autopsy $8.
           dsex $8.
           drace $8.
           dcity $40.
           dcounty $20.
           race $8.
           dmvflag $4.
           dmvdate DATE9.
           cvs $20.
           ssa861 $20.
           dla DATE9.
           seq_no 8.0;
    label autopsy =	"Autopsy"
          bdate = "Date of birth"
          cvs = "Vital status EOS 1983"
          dcity = "The city of death"
          dcounty = "The county of death"
          ddate = "Date of death"
          dla = "Date last alive"
          dmvdate = "Activity date returned by DMV"
          dmvflag = "Submitted to Ohio DMV in 1988"
          drace = "Race on death certificate"
          dsex = "Sex on death certificate"
          dstate = "The state of death"
          educ = "Education"
          hiredate = "Date of first hire at Mound"
          icda8 = "Cause of death - ICDA 8th revision"
          orauid = "Oak Ridge assigned id number"
          race = "Race of worker"
          seq_no = "Sequence Number of Row"
          sex = "Sex"
          ssa861 = "Results of a 1986 SSA submission"
          termdate = "Date of last termination from Mound";
run; 
proc format;
value $auto ' ' = "Not applicable"
            "0" = "No autopsy" 
            "1" = "Autopsy performed" 
            "N" = "No autopsy performed"
            "U" = "Unknown"
            "Y" = "Autopsy performed";
value $death "A" = "Alive"
             "D" = "Dead"
             "U" = "Unknown";
value $dmv " " = "Not submitted"
           "N" = "Not found"
           "Y" = "Found";
value $race " " = "Not applicable"
            "1" = "Oriental"
            "2" = "Native American"
            "3" = "Black"
            "U" = "Unknown";
value $sex " " = "Not applicable"
           "0" = "Male"
           "1" = "Female";         
value education 1 = "Grade school"
                2 = "Some high school"
                3 = "High school graduate"
                4 = "Associates Degree"
                5 = "College Graduate"
                6 = "Advanced Degree"
                9 = "Unknown";
value $rc " " = "Unknown"
          "0" = "White"
          "2" = "other"
          "3" = "Black";
value $se "0" = "Male"
          "1" = "Female"
          "9" = "Unknown";
value $ssa " " = "Not submitted"
           "A" = "Alive"
           "D" = "Dead"
           "I" = "Impossible SSN"
           "N" = "Non-match"
           "U" = "Unknown"
           "X" = "Duplicate";
run;
proc contents data=CEDR.MDFACW6   order=varnum;
run;
proc print data=CEDR.MDFACW6 (obs=5);
format autopsy $auto.
       cvs $death.
       dmvflag $dmv.
       drace $race.
       dsex $sex.
       educ education.
       race $rc.
       sex $se.
       ssa861 $ssa.;
run;