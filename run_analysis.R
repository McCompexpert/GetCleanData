setwd("P:\\Workouts\\Learn\\cleaning\\pa")

##### TASK 1 Merges the training and the test sets to create one data set.

### Read column headers
headers=read.table("./data/UCI HAR Dataset/features.txt")

##### TRAIN DATA SET #####

### Read train data
train = read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE)
### Re-name columns in train data with values from 2nd column in headers  
names(train)=headers$V2

### read subject and activity vectors in two separate dataframes
train_subject <-read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                           col.names=c("subject"))
train_activity <-read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                           col.names=c("activity"))
### add subject and activity to train dataframe
train=cbind(train_subject, train)
train=cbind(train_activity, train)

##### TEST DATA SET #####
test = read.table("./data/UCI HAR Dataset/test/X_test.txt",header=FALSE)
### Re-name columns in test data with values from 2nd column in headers  
names(test)=headers$V2
### read subject and activity vectors in two separate dataframes
test_subject <-read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                          col.names=c("subject"))
test_activity <-read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                           col.names=c("activity"))
### add subject and activity to train dataframe
test=cbind(test_subject, test)
test=cbind(test_activity, test)

##### MERGE TRAIN and TEST DATA SETS #####
aggregated=rbind(train,test)

### read activity labels into a dataframe
activity_labels <-read.table("./data/UCI HAR Dataset/activity_labels.txt")

##### TASK 3 Uses descriptive activity names to name 
##### the activities in the data set

### replace activity Ids with activity labels
aggregated$activity=factor(aggregated$activity,levels=1:6,
                           labels=activity_labels$V2)

##### TASK 2 Extracts only the measurements on the mean 
##### and standard deviation for each measurement. 

### leave activity and subject, get mean and std columns 
### and skip others in aggregated dataset
aggregated=aggregated[c(1, 2, grep("[Mm]ean|[Ss]td",colnames(aggregated)))]

### Create new data frame with means by subject and activity
result_dataset=aggregate(aggregated[3:88],
                         by=list(aggregated$activity, 
                                 aggregated$subject),FUN="mean")

##### TASK 4 Appropriately labels the data set with descriptive variable names

### provide labels for activity and subject
names(result_dataset)[1:2] <- c("activity", "subject")

##### TASK 5 Creates a second, independent tidy data set 
##### with the average of each variable for each activity and each subject.
### write the resulted tidy dataset to a csv file
write.csv(result_dataset, 
          file="./data/tidy_dataset.txt", na = "NA", 
          row.names=FALSE, eol = "\n", quote=FALSE)
