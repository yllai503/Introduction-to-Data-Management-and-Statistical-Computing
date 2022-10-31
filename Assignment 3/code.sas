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

data CEDR.MDFACW3;
set cedr.mdfacw6;
age_at_hire = (hiredate-bdate)/365;
age_at_death = (ddate-bdate)/365;
run;

proc means data=cedr.mdfacw3;
var age_at_hire age_at_death;
run;

*a;
proc sgplot data=cedr.mdfacw3;
histogram age_at_hire;
histogram age_at_death;
run;

proc sgplot data=cedr.mdfacw3;
vbox age_at_hire;
vbox age_at_death;
run;

*b;
proc means data=cedr.mdfacw3 n mean std nonobs maxdec=2;
where age_at_death lt 15;
var age_at_hire age_at_death;
run;

*c;
proc means data=cedr.mdfacw3 n mean std nonobs maxdec=2;
where age_at_hire lt 15 & age_at_death ne .;
var age_at_hire age_at_death;
run;

*d;
proc print data=cedr.mdfacw3;
where age_at_hire lt 15 & bdate ne . & hiredate ne .;
var orauid bdate sex educ hiredate termdate ddate age_at_hire;
run;

*e;
proc print data=cedr.mdfacw3;
where (age_at_hire lt 15 | age_at_hire gt 80) & bdate ne . & hiredate ne . ;
var orauid bdate sex educ hiredate termdate ddate age_at_hire;
run;

*Exercise2;
*a;
proc means data=cedr.mdfacw3 n mean std nonobs maxdec=2;
where hiredate gt termdate & hiredate ne . & termdate ne .;
var age_at_hire age_at_death;
run;

proc print data=cedr.mdfacw3;
where hiredate gt termdate & hiredate ne . & termdate ne .;
var orauid bdate hiredate termdate ddate age_at_hire;
run;

*b;
data CEDR.MDFACW3b;
set CEDR.MDFACW3;
date09151999 = "09/15/1999";
date09151999n = input(date09151999 , mmddyy10.);
diff_date= hiredate - date09151999n;
format diff_date  DATE9.;
drop date09151999;
rename date0915199n = date0915199;
run;

proc means data=cedr.mdfacw3b;
where date09151999n = hiredate;
var age_at_hire age_at_death;
run;

proc print data=cedr.mdfacw3b;
where date09151999n = hiredate;
var orauid bdate hiredate termdate ddate age_at_hire diff_date;
run;

*c;
proc means data=cedr.mdfacw3b;
where date09151999n = hiredate & ddate lt 0;
var age_at_hire age_at_death;
run;

proc print data=cedr.mdfacw3b;
where date09151999n = hiredate & ddate lt 0;
var orauid bdate hiredate termdate ddate age_at_hire diff_date;
run;

*d;
data CEDR.MDFACW3d;
set CEDR.MDFACW3b;
date07011999 = "07/01/1999";
date07011999n = input(date07011999 , mmddyy10.);
drop date07011999;
rename date07011999n = date07011999;
run;

proc means data=cedr.mdfacw3d;
where date07011999 = bdate;
var age_at_hire age_at_death;
run;

proc means data=cedr.mdfacw3d;
where date07011999 = bdate & date09151999n = hiredate;
var age_at_hire age_at_death;
run;

proc print data=cedr.mdfacw3d;
where date07011999 = bdate & date09151999n = hiredate;
var orauid bdate hiredate termdate ddate age_at_hire diff_date;
run;