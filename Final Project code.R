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


#data cleaning and delete missing NA variables and first 5 variables which is not useful#
training <- training[c(-1:-5)]

missingData = is.na(training)
omitColumns = which(colSums(missingData) > 19000)
training = training[, -omitColumns]
myDataNZV <- nearZeroVar(training, saveMetrics=TRUE)
myDataNZV

#seperate into training and testing data sets
inTrain <- createDataPartition(y=training$classe, p=0.6, list=FALSE)
myTraining <- training[inTrain, ]
myTesting <- training[-inTrain, ]
dim(myTraining)
dim(myTesting)

#model
set.seed(11111)
modFit1 <- randomForest(classe ~ ., data=myTraining)
varImp(modFit1)

#predict on test data
prediction1 <- predict(modFit1, myTesting, type = "class")
cmrf <- confusionMatrix(prediction1, myTesting$classe)
cmrf

#predict on the 20 observation
vars <- colnames(myTraining[, -55])  # remove the classe column
testing <- testing[vars]         

# make test data into the same type as training data
for (i in 1:length(testing) ) {
  for(j in 1:length(myTraining)) {
    if( length( grep(names(myTraining[i]), names(testing)[j]) ) == 1)  {
      class(testing[j]) <- class(myTraining[i])
    }      
  }      
  
testing <- rbind(myTraining[2, -55] , testing)
testing <- testing[-1,]

prediction2 <- predict(modFit1, testing, type = "class")
prediction2


