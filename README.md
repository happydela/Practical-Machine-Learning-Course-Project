# Practical-Machine-Learning-Course-Project

Background

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset).

You will see the following steps in the project.

1) Data cleaning
There are a lot of variables with 'NA' values, so I removed these variables. And also removed the first 5 variables that should not be considered as predictive variabels.
Finally, there are 55 variables left.
I split into 60% training data set and 40% validation/testing data set.
> missingData = is.na(training)
> omitColumns = which(colSums(missingData) > 19000)
> training = training[, -omitColumns]
> myDataNZV <- nearZeroVar(training, saveMetrics=TRUE)
> myDataNZV
                     freqRatio percentUnique zeroVar   nzv
new_window           47.330049    0.01019264   FALSE  TRUE
num_window            1.000000    4.37264295   FALSE FALSE
roll_belt             1.101904    6.77810621   FALSE FALSE
pitch_belt            1.036082    9.37722964   FALSE FALSE
yaw_belt              1.058480    9.97349913   FALSE FALSE
total_accel_belt      1.063160    0.14779329   FALSE FALSE
gyros_belt_x          1.058651    0.71348486   FALSE FALSE
gyros_belt_y          1.144000    0.35164611   FALSE FALSE
gyros_belt_z          1.066214    0.86127816   FALSE FALSE
accel_belt_x          1.055412    0.83579655   FALSE FALSE
accel_belt_y          1.113725    0.72877383   FALSE FALSE
accel_belt_z          1.078767    1.52379982   FALSE FALSE
magnet_belt_x         1.090141    1.66649679   FALSE FALSE
magnet_belt_y         1.099688    1.51870350   FALSE FALSE
magnet_belt_z         1.006369    2.32901845   FALSE FALSE
roll_arm             52.338462   13.52563449   FALSE FALSE
pitch_arm            87.256410   15.73234125   FALSE FALSE
yaw_arm              33.029126   14.65701763   FALSE FALSE
total_accel_arm       1.024526    0.33635715   FALSE FALSE
gyros_arm_x           1.015504    3.27693405   FALSE FALSE
gyros_arm_y           1.454369    1.91621649   FALSE FALSE
gyros_arm_z           1.110687    1.26388747   FALSE FALSE
accel_arm_x           1.017341    3.95984099   FALSE FALSE
accel_arm_y           1.140187    2.73672409   FALSE FALSE
accel_arm_z           1.128000    4.03628580   FALSE FALSE
magnet_arm_x          1.000000    6.82397309   FALSE FALSE
magnet_arm_y          1.056818    4.44399144   FALSE FALSE
magnet_arm_z          1.036364    6.44684538   FALSE FALSE
roll_dumbbell         1.022388   84.20650290   FALSE FALSE
pitch_dumbbell        2.277372   81.74498012   FALSE FALSE
yaw_dumbbell          1.132231   83.48282540   FALSE FALSE
total_accel_dumbbell  1.072634    0.21914178   FALSE FALSE
gyros_dumbbell_x      1.003268    1.22821323   FALSE FALSE
gyros_dumbbell_y      1.264957    1.41677709   FALSE FALSE
gyros_dumbbell_z      1.060100    1.04984201   FALSE FALSE
accel_dumbbell_x      1.018018    2.16593619   FALSE FALSE
accel_dumbbell_y      1.053061    2.37488533   FALSE FALSE
accel_dumbbell_z      1.133333    2.08949139   FALSE FALSE
magnet_dumbbell_x     1.098266    5.74864948   FALSE FALSE
magnet_dumbbell_y     1.197740    4.30129447   FALSE FALSE
magnet_dumbbell_z     1.020833    3.44511263   FALSE FALSE
roll_forearm         11.589286   11.08959331   FALSE FALSE
pitch_forearm        65.983051   14.85577413   FALSE FALSE
yaw_forearm          15.322835   10.14677403   FALSE FALSE
total_accel_forearm   1.128928    0.35674243   FALSE FALSE
gyros_forearm_x       1.059273    1.51870350   FALSE FALSE
gyros_forearm_y       1.036554    3.77637346   FALSE FALSE
gyros_forearm_z       1.122917    1.56457038   FALSE FALSE
accel_forearm_x       1.126437    4.04647844   FALSE FALSE
accel_forearm_y       1.059406    5.11160942   FALSE FALSE
accel_forearm_z       1.006250    2.95586586   FALSE FALSE
magnet_forearm_x      1.012346    7.76679238   FALSE FALSE
magnet_forearm_y      1.246914    9.54031189   FALSE FALSE
magnet_forearm_z      1.000000    8.57710733   FALSE FALSE
classe                1.469581    0.02548160   FALSE FALSE
> inTrain <- createDataPartition(y=training$classe, p=0.6, list=FALSE)
> myTraining <- training[inTrain, ]
> myTesting <- training[-inTrain, ]
> dim(myTraining)
[1] 11776    55
> dim(myTesting)
[1] 7846   55
> 

2) Build random forest model
> set.seed(11111)
> modFit1 <- randomForest(classe ~ ., data=myTraining)

3) Cross validation
> #predict on test data
> prediction1 <- predict(modFit1, myTesting, type = "class")
> cmrf <- confusionMatrix(prediction1, myTesting$classe)
> cmrf
Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 2232    6    0    0    0
         B    0 1511   10    0    0
         C    0    1 1358    7    0
         D    0    0    0 1276    0
         E    0    0    0    3 1442

Overall Statistics
                                         
               Accuracy : 0.9966         
                 95% CI : (0.995, 0.9977)
    No Information Rate : 0.2845         
    P-Value [Acc > NIR] : < 2.2e-16      
                                         
                  Kappa : 0.9956         
 Mcnemar's Test P-Value : NA             

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            1.0000   0.9954   0.9927   0.9922   1.0000
Specificity            0.9989   0.9984   0.9988   1.0000   0.9995
Pos Pred Value         0.9973   0.9934   0.9941   1.0000   0.9979
Neg Pred Value         1.0000   0.9989   0.9985   0.9985   1.0000
Prevalence             0.2845   0.1935   0.1744   0.1639   0.1838
Detection Rate         0.2845   0.1926   0.1731   0.1626   0.1838
Detection Prevalence   0.2852   0.1939   0.1741   0.1626   0.1842
Balanced Accuracy      0.9995   0.9969   0.9957   0.9961   0.9998

4) Test sample error
Error on the test datasets is 1-0.9966=0.0034

5) Prediction on the 20 samples
> prediction2 <- predict(modFit1, testing, type = "class")
> prediction2
 2  3  4 51  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 
 B  A  B  A  A  E  D  B  A  A  B  C  B  A  E  E  A  B  B  B 
Levels: A B C D E

