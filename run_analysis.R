library(tidyr)
library(dplyr)

#Load the two data sets:
#TRAIN:
train_df<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
#TEST:
test_df<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)

#Merge the data sets into one:
merged_df<-rbind(train_df,test_df)

#Load the variable names, and set them:
var_names<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE, header=FALSE)
colnames(merged_df)<-var_names[,2]

#Select only those features on the mean or the std:
feat_sel<-grep("mean\\(|std\\(",colnames(merged_df))
merged_subset<-merged_df[,feat_sel]

#Load the activity labels:
train_activity<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names=c("id_activity"))
test_activity<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,col.names=c("id_activity"))
activities<-rbind(train_activity,test_activity)
act_lab<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("id_activity","name_activity"))
act_labelled<-left_join(activities,act_lab)
col_names_merged<-colnames(merged_subset)
merged_sub_act<-cbind(merged_subset,act_labelled$name_activity)
colnames(merged_sub_act)<-c(col_names_merged,"name_activity")

#Load the subject ids:
train_subj<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names=c("subject_id"))
test_subj<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,col.names=c("subject_id"))
subjects<-rbind(train_subj,test_subj)
mergedFinal<-cbind(merged_sub_act,subjects)

#Eliminate the "()", and subtitute "-" for "_" to make the variable names cleaner:
colnames(mergedFinal)<-gsub("\\(\\)","",colnames(mergedFinal))
colnames(mergedFinal)<-gsub("-","_",colnames(mergedFinal))

#Create another dataset with the average values of the selected features grouped by subject and activity:
summary_df<- summarise_if(group_by(mergedFinal,subject_id,name_activity),is.numeric,mean,na.rm=TRUE)

#Write the final data set into a csv:
write.table(summary_df,"./final_summary.txt",row.names=FALSE)
