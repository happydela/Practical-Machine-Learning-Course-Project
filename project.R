getwd()
setwd("/Users/xx/Downloads/Coursera_MachineLearning/Chapter 4")
, sep="\t"

training <- read.table(file="pml-training.csv",sep = ",", header=T)
summary(training)

training[!complete.cases(training),]


is.fact <- sapply(training, is.factor)
factors.df <- training[, is.fact]
lapply(factors.df, levels)
training<-as.numeric(as.character(training)) #first convert each column into numeric if it is from factor
x[is.na(x)] =median(x, na.rm=TRUE) 

vars<-grep("^[v][a][r]", names(training), value=TRUE)
training[,vars]

preProc<-preProcess(training[,vars], method="pca",thresh=0.8)

modFit <- randomForest(classe ~ ., data=training,prox=TRUE, ntree=10, importance=TRUE,na.action = na.exclude)
modFit <-train(y~.,data=vowel.test, method="rf", prox=TRUE,importance = TRUE)
varImp(modFit, scale = TRUE)
modFit <-train(y~.,data=training, method="rf", prox=TRUE,ntree=10, importance = TRUE)

training$X <-NULL
training$cvtd_timestamp<-NULL



library(caret)
library(rpart)
library(rpart.plot)
library(rattle)
library(AppliedPredictiveModeling)
library(randomForest)
set.seed(11111)

trainUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

training <- read.csv(url(trainUrl), na.strings=c("NA","#DIV/0!",""))
testing <- read.csv(url(testUrl), na.strings=c("NA","#DIV/0!",""))

inTrain <- createDataPartition(y=training$classe, p=0.6, list=FALSE)
myTraining <- training[inTrain, ]; myTesting <- training[-inTrain, ]
dim(myTraining); dim(myTesting)

#data cleaning and delete missing NA variables#
myTraining <- myTraining[c(-1)]

missingData = is.na(myTraining)
omitColumns = which(colSums(missingData) > 11000)
myTraining = myTraining[, -omitColumns]
myDataNZV <- nearZeroVar(myTraining, saveMetrics=TRUE)
myDataNZV

