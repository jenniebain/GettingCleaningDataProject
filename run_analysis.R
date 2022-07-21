library(dplyr)
library(tidyr)

## Download the data and unzip it
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/measurementData.zip",method="curl")
if(!file.exists("UCI HAR Dataset")){unzip("./data/measurementData.zip")}

## Load the data labels - note this loads 2 columns: id and label
data_labels <- read.table("UCI HAR Dataset/features.txt",header=FALSE)

## remove the id column
data_labels <- data_labels[-c(1)]

## turn the rows into columns of a data frame
labels_df <- as.data.frame(t(data_labels))

## read the testing and training measurement data
test_data <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
train_data <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)

## read the testing and training activity codes
test_activity <- read.table("UCI HAR Dataset/test/Y_test.txt",header=FALSE)
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

## read the testing and training subject codes
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)

## set the column names of the testing and training measurement data to the data labels loaded
names(test_data) <- labels_df[1,]
names(train_data) <- labels_df[1,]

## set the name of the single columns in each of the testing and training activity data frames to 'activity'
test_activity <- rename(test_activity,activity=V1)
train_activity <- rename(train_activity,activity=V1)

## set the name of the single columns in each of the testing and training subject data frames to 'subject'
test_subject <- rename(test_subject,subject=V1)
train_subject <- rename(train_subject,subject=V1)

## select only the measurement records for mean and standard deviation
test_meanstd <- test_data[,grep("mean\\(|std\\(",names(test_data))]
train_meanstd <- train_data[,grep("mean\\(|std\\(",names(train_data))]

## append the activity data to the testing and training measurement data frames
test_meanstd <- cbind(test_meanstd,test_activity)
train_meanstd <- cbind(train_meanstd,train_activity)

## append the subject data to the testing and training measurement data frames
test_meanstd <- cbind(test_meanstd,test_subject)
train_meanstd <- cbind(train_meanstd,train_subject)

## combine the testing and training data into a single data frame
all_data <- rbind(test_meanstd,train_meanstd)

## read the activity labels into a lookup table
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE) 

## set appropriate column header names
activity_labels <- rename(activity_labels,activitynumber=V1,activityname=V2)

## replace the activity number with the activity name
all_data$activity <- factor(all_data$activity, levels = activity_labels$activitynumber, labels = activity_labels$activityname)

## replace initial t with time and f with frequency
names(all_data) <- sub("^t","time",names(all_data))
names(all_data) <- sub("^f","frequency",names(all_data))

## expand 'accelerometer', 'gyroscope', and 'magnitude'
names(all_data) <- sub("Acc","Accelerometer",names(all_data))
names(all_data) <- sub("Gyro","Gyroscope",names(all_data))
names(all_data) <- sub("Mag","Magnitude",names(all_data))

## remove dashes and parentheses and capitalize Mean and Std
names(all_data) <- sub("mean","Mean",names(all_data))
names(all_data) <- sub("std","SD",names(all_data))
names(all_data) <- gsub("-","",names(all_data))
names(all_data) <- sub("\\(\\)","",names(all_data))
names(all_data) <- sub("BodyBody","Body",names(all_data))

## Create a tidy data set where each measurement is its own column.
tidy_measure <- pivot_longer(all_data,-c(subject,activity),names_to="measurement",values_to="value")

## Find the mean of each measurement for each subject and activity
tidy_measure %>%
  group_by(subject,activity,measurement) %>%
  summarize(mean = mean(value)) ->
  tidy_summary


## If the output file exists, remove it. Write the tidy data set to a file
if(file.exists("tidyData.txt")) {unlink("tidyData.txt",recursive=FALSE)}
write.table(tidy_summary,"tidyData.txt",row.name=FALSE)



