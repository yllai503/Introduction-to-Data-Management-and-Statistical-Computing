stroke.data <- read.csv("D:/UCLA Biostat/Fall 2021/Biostat 203A/Project2/healthcare-dataset-stroke-data.csv",
                   header = T, sep = ",")
#delete id because it can cause unwanted correlation
stroke.data <- stroke.data[,-c(1)]

#201 NAs in bmi
stroke.data$bmi <- as.numeric(stroke.data$bmi)
sum(is.na(stroke.data$bmi))

#imputation for bmi using MICE
require(mice)
mice.stroke.data <- mice(stroke.data, m = 3, maxit = 50,method = "cart", seed = 203)
stroke.data <- complete(mice.stroke.data, 2)

stroke.data$gender = factor(stroke.data$gender)
stroke.data$hypertension = factor(stroke.data$hypertension)
stroke.data$heart_disease = factor(stroke.data$heart_disease)
stroke.data$ever_married = factor(stroke.data$ever_married)
stroke.data$work_type = factor(stroke.data$work_type)
stroke.data$Residence_type = factor(stroke.data$Residence_type)
stroke.data$smoking_status = factor(stroke.data$smoking_status)
stroke.data$stroke = factor(stroke.data$stroke)

###Figure1
library(ggplot2)
ggplot(stroke.data, aes(x = age, y = avg_glucose_level)) +
  geom_point(aes(color = factor(stroke)))+
  labs(title = "Scatter plot of age and average glucose level in blood grouped by stroke",
       y = "Average glucose level in blood",
       color = "Stroke")+
  scale_color_manual(labels = c("No", "Yes"), values = c("lightblue", "tomato1"))+
  theme_light()


###Table1 - multivariate analysis
library(MASS)
# Fit the full model 
full.model <- glm(stroke ~ ., 
                  data = stroke.data, 
                  family = "binomial")
# Stepwise regression model
step.model <- stepAIC(full.model, direction = "both", 
                      trace = FALSE)
summary(step.model)

final.model <- glm(stroke ~ age+hypertension+avg_glucose_level, 
                   data = stroke.data, 
                   family = "binomial")
summary(final.model)

stroke.data.numeric <- stroke.data
stroke.data.numeric$stroke <- as.numeric(stroke.data.numeric$stroke)-1
final.model_numeric <- glm( stroke ~ age+avg_glucose_level, 
                   data = stroke.data.numeric, 
                   family = "binomial")
summary(final.model_numeric)

###Figure1 - multivariate analysis
library(moonBook) 
require(ggplot2)
require(ggiraph)
require(ggiraphExtra)
require(plyr)
ggPredict(final.model_numeric,se=TRUE,interactive=TRUE)

###Table2 - classification

##Logistic regression(0.950537634408602)
library(caTools)
library(ROCR) 
split <- sample.split(stroke.data, SplitRatio = 0.8)
split

# Splitting dataset
train_reg <- subset(stroke.data, split == "TRUE")
test_reg <- subset(stroke.data, split == "FALSE")

# Training model

logistic_model <- glm(stroke ~ age + hypertension + heart_disease + avg_glucose_level, 
                      data = train_reg, 
                      family = "binomial")
logistic_model

# Summary
summary(logistic_model)

# Predict test data based on model
predict_reg <- predict(logistic_model, 
                       newdata = test_reg, type = "response")
predict_reg  

# Changing probabilities
predict_reg <- ifelse(predict_reg >0.5, 1, 0)

# Evaluating model accuracy
# using confusion matrix
table(test_reg$stroke, predict_reg)

missing_classerr <- mean(predict_reg != test_reg$stroke)
print(paste('Accuracy =', 1 - missing_classerr))
library(caret)

##LDA(0.9491039)
lda.fit=lda(stroke ~ age + hypertension + heart_disease + avg_glucose_level, 
               data = train_reg, 
               family = "binomial")
lda.fit
lda.pred=predict(lda.fit,test_reg)
lda.class =lda.pred$class
table(lda.class,test_reg$stroke)
(1320+4)/1395

##QDA(0.8853047)
qda.fit=qda(stroke ~ age + hypertension + heart_disease + avg_glucose_level, 
            data = train_reg, 
            family = "binomial")
qda.fit
qda.pred=predict(qda.fit,test_reg)
qda.class =qda.pred$class
table(qda.class,test_reg$stroke)
(1208+27)/1395



##KNN(0.9491039)
train_numeric <- train_reg[,c(1,2,3,4,5,8,9,11)]
train_numeric$gender <- ifelse(train_numeric$gender=="Male",1,0)
train_numeric$ever_married <- ifelse(train_numeric$ever_married=="Yes",1,0)
test_numeric <- test_reg[,c(1,2,3,4,5,8,9,11)]
test_numeric$gender <- ifelse(test_numeric$gender=="Male",1,0)
test_numeric$ever_married <- ifelse(test_numeric$ever_married=="Yes",1,0)

library(class)
knn.pred=knn(train_numeric,test_numeric,train_numeric$stroke,k=10)
table(knn.pred,test_numeric$stroke)
mean(knn.pred==test_numeric$stroke)
(1323+1)/1395



##Random Forest(0.9505376)
library(rsample)      # data splitting 
library(randomForest) # basic implementation
library(ranger)       # a faster implementation of randomForest
library(caret)        # an aggregator package for performing many machine learning models
library(h2o)          # an extremely fast java-based platform
library(dplyr)
library(magrittr)

rf <- randomForest(as.factor(stroke) ~ .,data = train_reg, n_tree = 100)
rf.pred.prob <- predict(object = rf, newdata = test_reg, type = "prob")
rf.pred <- predict(rf, newdata = test_reg, type = "class")
tbrf <- table(rf.pred, test_reg$stroke)
tbrf
1326/1395


##SVM(0.9505376)
library(kernlab)
svm <- ksvm(as.factor(stroke) ~ .,data = train_reg)
svm.pred.prob <- predict(svm,test_reg, type = "decision")
svm.pred <- predict(svm,test_reg, type = "response")
tbsvm <- table(svm.pred, test_reg$stroke)
tbsvm
1326/1395


write.csv(stroke.data, "D:/UCLA Biostat/Fall 2021/Biostat 203A/Project2/final_dataset.csv", row.names = FALSE)
summary(stroke.data)
