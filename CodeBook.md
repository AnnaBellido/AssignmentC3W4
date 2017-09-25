# Code book

This code book describes the variables in the *final_summary.csv* file, in addition to the procedure followed to obtain such data. This data set was calculated from a list of data sets storing the results of an experiment, where participants had a Samsung Galaxy S at the height of their hips, and the data from the accelerometer was continuously stored (rate of 50Hz) as they did an activity (from a list of possible options). 

## Variables

They can either be identifiers or summary data. 

The identifiers are the variables *name_activity* and *subject_id*:
* *name_activity*: the name of the activity the subject was performing when the recording was obtained. All the possible activities were WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.
* *subject_id*: this is a positive integer value assigned to each participant in the experiment

The summary data corresponded to the rest of the variables. They are real numbers representing the average value on each feature selected (the selection of features is detailed in the "Procedure" section).
The list of those variables is: 
* *tBodyAcc_mean_X*
* *tBodyAcc_mean_Y*
* *tBodyAcc_mean_Z*
* *tBodyAcc_std_X*
* *tBodyAcc_std_Y*
* *tBodyAcc_std_Z*
* *tGravityAcc_mean_X*
* *tGravityAcc_mean_Y*
* *tGravityAcc_mean_Z*
* *tGravityAcc_std_X*
* *tGravityAcc_std_Y*
* *tGravityAcc_std_Z*
* *tBodyAccJerk_mean_X*
* *tBodyAccJerk_mean_Y*
* *tBodyAccJerk_mean_Z*
* *tBodyAccJerk_std_X*
* *tBodyAccJerk_std_Y*
* *tBodyAccJerk_std_Z*
* *tBodyGyro_mean_X*
* *tBodyGyro_mean_Y*
* *tBodyGyro_mean_Z*
* *tBodyGyro_std_X*
* *tBodyGyro_std_Y*
* *tBodyGyro_std_Z*
* *tBodyGyroJerk_mean_X*
* *tBodyGyroJerk_mean_Y*
* *tBodyGyroJerk_mean_Z*
* *tBodyGyroJerk_std_X*
* *tBodyGyroJerk_std_Y*
* *tBodyGyroJerk_std_Z*
* *tBodyAccMag_mean*
* *tBodyAccMag_std*
* *tGravityAccMag_mean*
* *tGravityAccMag_std*
* *tBodyAccJerkMag_mean*
* *tBodyAccJerkMag_std*
* *tBodyGyroMag_mean*
* *tBodyGyroMag_std*
* *tBodyGyroJerkMag_mean*
* *tBodyGyroJerkMag_std*
* *fBodyAcc_mean_X*
* *fBodyAcc_mean_Y*
* *fBodyAcc_mean_Z*
* *fBodyAcc_std_X*
* *fBodyAcc_std_Y*
* *fBodyAcc_std_Z*
* *fBodyAccJerk_mean_X*
* *fBodyAccJerk_mean_Y*
* *fBodyAccJerk_mean_Z*
* *fBodyAccJerk_std_X*
* *fBodyAccJerk_std_Y*
* *fBodyAccJerk_std_Z*
* *fBodyGyro_mean_X*
* *fBodyGyro_mean_Y*
* *fBodyGyro_mean_Z*
* *fBodyGyro_std_X*
* *fBodyGyro_std_Y*
* *fBodyGyro_std_Z*
* *fBodyAccMag_mean*
* *fBodyAccMag_std*
* *fBodyBodyAccJerkMag_mean*
* *fBodyBodyAccJerkMag_std*
* *fBodyBodyGyroMag_mean*
* *fBodyBodyGyroMag_std*
* *fBodyBodyGyroJerkMag_mean*
* *fBodyBodyGyroJerkMag_std*


## Procedure

The first step was gathering all the data of the training set and the test set of data. Participants were randomly assigned either one or the other, but posterior analysis needs the two data sets to be joined together. I used the function _rbind_ to obtain the final data set. 


I loaded the file with the stored feature names in the training and the test files, and used those names as variable names for the data set previously obtained. 


These variables names allowed to subset only those variables on the mean and the standard deviation, which are the variables we are interested in. 


The final goal is to obtain the mean of each of those variables grouping by subject and the activity the subject was doing. For this, we need to add the information related to those activities and subjects. I loaded the files with the activity codes of each recording in the data set (training and test), I merged the data with **rbind**, and I merged it with the table that stored the corresponding activity name using the function **left_join**. Finally, I included the new column with the activity names in the data set with the recordings with the function **cbind**. Regarding the subjects id, I loaded the file with those ids per recording and attached it to the previous data set also with the function **cbind**. 
The last step was running the summary function over the data set obtained grouped by the subject id and the activity name. Since we want to get the mean value of all the variables, I used the function **summary_if** and I indicated as condition that the variable had to be numeric (*is.numeric*). Then, what I did was using the function **group_by** to be able to group by subject id and activity name, and passed the result to the **summary_if**, which returned the desired result.


In order to make the variable names more readable, I also eliminated the characters "()", and subtituted the character "-" for "_ " in all the variable names. I used the function **gsub** for both purposes. 
