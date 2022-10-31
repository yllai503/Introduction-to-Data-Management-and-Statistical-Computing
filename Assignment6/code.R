ted <- read.csv("D:/UCLA Biostat/Fall 2021/Biostat 203A/Assignment6/TED_Talks.csv", header = T)
ted$headline[ted$speaker == "Hans Rosling"]

ted2 <- ted
ted2$speaker[ted$speaker == "Hans Rosling"] <- "Yenlin Lai"
ted2[ted$speaker == "Hans Rosling",2:3]

ted.17 <- ted[ted$year_filmed == 2017,]
nrow(ted.17)

ted2$popular <- "N"
ted2$popular[ted2$views_as_of_06162017 >= 1000000] <- "Y"
ted2$popular[1:10]


install.packages("sas7bdat")
library(sas7bdat)
phq9 <- read.sas7bdat("D:/UCLA Biostat/Fall 2021/Biostat 203A/Assignment6/phq9.sas7bdat")


phq9.b <- phq9[phq9$BHC_TYPE_FFU == "BASELINE",]
phq9.f <- phq9[phq9$BHC_TYPE_FFU == "FIRSTFOLLOWUP",]
phq9.bf <- merge(phq9.b, phq9.f, by="IDNUM")
phq9.bf$improve <- "N"
phq9.bfnew <- phq9.bf[phq9.bf$PHQ9_TS.x >= 10,]
phq9.bfnew$percentage = (phq9.bfnew$PHQ9_TS.x-phq9.bfnew$PHQ9_TS.y)/phq9.bfnew$PHQ9_TS.x

for (n in 1:nrow(phq9.bfnew)) {
  if(phq9.bfnew$PHQ9_TS.y[n] < 10 | phq9.bfnew$percentage[n] >= 0.5) {
  phq9.bfnew$improve[n] <- "Y"
  } 
  else {phq9.bfnew$improve[n] <- "N"
  }
}
table(phq9.bfnew$improve)
phq9.bfnew[1:10,]
