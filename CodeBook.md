---
title: "Getting and Cleaning Data - Course Project"
author: "Jennie Bain"
date: '2022-07-21'
output: html_document
---

## Project Description

This project is intended to demonstrate the ability to collect, work with, and clean a data set and is the final project in the Getting and Cleaning Data course. The goal of the assignment is to produce a readme file, a codebook, and an R script called run_analysis.R that does the following:
1. Merges the training and test sets to create one data set.
2. Extracts only the measurements on mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data Source
The data provided for this project represents data collected from the accelerometers of Samsung Galaxy S smartphones worn on the waist by 30 volunteers aged 19-48. Data was collected from each subject while they performed 6 different activities (walking, walking upstairs, walking downstairs, sitting, standing, and laying). As noted in the data source: 

> "The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain." (Anguita et al., 2013)

The data provided was divided into training and test data so that those working with machine learning would have data to use for training and new data for testing. For this project, we will combine all the data into a single data source. 

Each measurement record includes 561 measurements covering the triaxial acceleration from the accelerometer (total acceleration), the estimated body acceleration, and the triaxial angular velocity from the gyroscope. These measurements are paired with the subject id and the type of activity being performed during the measurement.  

Files included in the data set include:

* subject_test.txt/subject_train.txt: Subject id for each line of data
* X_test.txt/X_train.txt: Measurements collected
* y_test.txt/y_train.txt: Activity codes for each line of data
* activity_labels.txt: Lookup table relating activity codes to a text description of the activity
* features.txt: Names of the measurements contained in X_test.txt/X_train.txt
* features_info.txt: Information about the measurements collected
* README.txt: Information about the data set
* For both test and training data, data relating to inertial signals is provided but is not relevant to this project and not used

## Transformation Steps
To transform the data into a tidy data set, the data was first [downloaded](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzipped. The following steps were then performed:

1. All the necessary data files were read into variables (this includes both test and training data for subject ids, measurements, activity codes, activity descriptions, and variable labels).
2. The variable names were applied as column names to each of the test and training measurement data frames.
3. The activity and subject data frames were given appropriate column names.
4. Columns not including mean or standard deviation information were filtered out.
    + I chose to only include those measurements with mean or standard deviation as the final aspect of the measurement.
5. Activity codes and subject ids were added as additional columns to the test and training data frames
6. The test and training data frames were combined into a single data frame.
7. The activity codes were substituted with the appropriate activity description.
8. Variable names were cleaned up and abbreviations expanded to be more descriptive.
    + 't' at the start of a name was replaced with 'time'
    + 'f' at the start of a name was replaced with 'frequency'
    + 'Acc' was replaced with 'Accelerometer'
    + 'Gyro' was replaced with 'Gyroscope'
    + 'Mag' was replaced with 'Magnitude'
    + Special characters were removed
    + Duplicate words in varible names were removed

At this point, the data frame all_data contains the cleaned data as defined in the requirements.

The following steps were then performed to create an independent tidy data set:

1. The data was transformed into a longer data set where each measurement is stored in its own row. Each row includes the subject id, activity type, measurement name, and measurement value.
2. This data was grouped by subject, activity, and measurement type and a mean was found for each group.
3. This tidy data set was written to a file called "tidyData.txt" in the working directory.
    + If the file already exists, it is removed prior to writing the new file.
  
The tidy data set is contained in a data frame called tidy_summary.

## Key Variables

Each record in both all_data and the tidy data set, tidy_summary, includes the following variables.

| Name     | Description                             | Values                                                                   |
|----------|-----------------------------------------|--------------------------------------------------------------------------|
| subject  | ID of subject                           | 1-30                                                                     |
| activity | Description of activity being performed | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING |

## Measurement Variables

These variables are included as columns in all_data and as rows with corresponding values in the tidy data set, tidy_summary.

Note: Values are normalized and bounded within [-1,1]

| Name                                        | Measurement Type | Motion Type | Sensor Signal | Jerk Measurement | Magnitude | Calculation Type   | Axis |
|---------------------------------------------|------------------|-------------|---------------|-----------------|-----------|--------------------|------|
| timeBodyAccelerometerMeanX                  | time             | body        | accelerometer | no              | no        | mean               | X    |
| timeBodyAccelerometerMeanY                  | time             | body        | accelerometer | no              | no        | mean               | Y    |
| timeBodyAccelerometerMeanZ                  | time             | body        | accelerometer | no              | no        | mean               | Z    |
| timeBodyAccelerometerSDX                    | time             | body        | accelerometer | no              | no        | standard deviation | X    |
| timeBodyAccelerometerSDY                    | time             | body        | accelerometer | no              | no        | standard deviation | Y    |
| timeBodyAccelerometerSDZ                    | time             | body        | accelerometer | no              | no        | standard deviation | Z    |
| timeGravityAccelerometerMeanX               | time             | gravity     | accelerometer | no              | no        | mean               | X    |
| timeGravityAccelerometerMeanY               | time             | gravity     | accelerometer | no              | no        | mean               | Y    |
| timeGravityAccelerometerMeanZ               | time             | gravity     | accelerometer | no              | no        | mean               | Z    |
| timeGravityAccelerometerSDX                 | time             | gravity     | accelerometer | no              | no        | standard deviation | X    |
| timeGravityAccelerometerSDY                 | time             | gravity     | accelerometer | no              | no        | standard deviation | Y    |
| timeGravityAccelerometerSDZ                 | time             | gravity     | accelerometer | no              | no        | standard deviation | Z    |
| timeBodyAccelerometerJerkMeanX              | time             | body        | accelerometer | yes             | no        | mean               | X    |
| timeBodyAccelerometerJerkMeanY              | time             | body        | accelerometer | yes             | no        | mean               | Y    |
| timeBodyAccelerometerJerkMeanZ              | time             | body        | accelerometer | yes             | no        | mean               | Z    |
| timeBodyAccelerometerJerkSDX                | time             | body        | accelerometer | yes             | no        | standard deviation | X    |
| timeBodyAccelerometerJerkSDY                | time             | body        | accelerometer | yes             | no        | standard deviation | Y    |
| timeBodyAccelerometerJerkSDZ                | time             | body        | accelerometer | yes             | no        | standard deviation | Z    |
| timeBodyGyroscopeMeanX                      | time             | body        | gyroscope     | no              | no        | mean               | X    |
| timeBodyGyroscopeMeanY                      | time             | body        | gyroscope     | no              | no        | mean               | Y    |
| timeBodyGyroscopeMeanZ                      | time             | body        | gyroscope     | no              | no        | mean               | Z    |
| timeBodyGyroscopeSDX                        | time             | body        | gyroscope     | no              | no        | standard deviation | X    |
| timeBodyGyroscopeSDY                        | time             | body        | gyroscope     | no              | no        | standard deviation | Y    |
| timeBodyGyroscopeSDZ                        | time             | body        | gyroscope     | no              | no        | standard deviation | Z    |
| timeBodyGyroscopeJerkMeanX                  | time             | body        | gyroscope     | yes             | no        | mean               | X    |
| timeBodyGyroscopeJerkMeanY                  | time             | body        | gyroscope     | yes             | no        | mean               | Y    |
| timeBodyGyroscopeJerkMeanZ                  | time             | body        | gyroscope     | yes             | no        | mean               | Z    |
| timeBodyGyroscopeJerkSDX                    | time             | body        | gyroscope     | yes             | no        | standard deviation | X    |
| timeBodyGyroscopeJerkSDY                    | time             | body        | gyroscope     | yes             | no        | standard deviation | Y    |
| timeBodyGyroscopeJerkSDZ                    | time             | body        | gyroscope     | yes             | no        | standard deviation | Z    |
| timeBodyAccelerometerMagnitudeMean          | time             | body        | accelerometer | no              | yes       | mean               |      |
| timeBodyAccelerometerMagnitudeSD            | time             | body        | accelerometer | no              | yes       | standard deviation |      |
| timeGravityAccelerometerMagnitudeMean       | time             | gravity     | accelerometer | no              | yes       | mean               |      |
| timeGravityAccelerometerMagnitudeSD         | time             | gravity     | accelerometer | no              | yes       | standard deviation |      |
| timeBodyAccelerometerJerkMagnitudeMean      | time             | body        | accelerometer | yes             | yes       | mean               |      |
| timeBodyAccelerometerJerkMagnitudeSD        | time             | body        | accelerometer | yes             | yes       | standard deviation |      |
| timeBodyGyroscopeMagnitudeMean              | time             | body        | gyroscope     | no              | yes       | mean               |      |
| timeBodyGyroscopeMagnitudeSD                | time             | body        | gyroscope     | no              | yes       | standard deviation |      |
| timeBodyGyroscopeJerkMagnitudeMean          | time             | body        | gyroscope     | yes             | yes       | mean               |      |
| timeBodyGyroscopeJerkMagnitudeSD            | time             | body        | gyroscope     | yes             | yes       | standard deviation |      |
| frequencyBodyAccelerometerMeanX             | frequency        | body        | accelerometer | no              | no        | mean               | X    |
| frequencyBodyAccelerometerMeanY             | frequency        | body        | accelerometer | no              | no        | mean               | Y    |
| frequencyBodyAccelerometerMeanZ             | frequency        | body        | accelerometer | no              | no        | mean               | Z    |
| frequencyBodyAccelerometerSDX               | frequency        | body        | accelerometer | no              | no        | standard deviation | X    |
| frequencyBodyAccelerometerSDY               | frequency        | body        | accelerometer | no              | no        | standard deviation | Y    |
| frequencyBodyAccelerometerSDZ               | frequency        | body        | accelerometer | no              | no        | standard deviation | Z    |
| frequencyBodyAccelerometerJerkMeanX         | frequency        | body        | accelerometer | yes             | no        | mean               | X    |
| frequencyBodyAccelerometerJerkMeanY         | frequency        | body        | accelerometer | yes             | no        | mean               | Y    |
| frequencyBodyAccelerometerJerkMeanZ         | frequency        | body        | accelerometer | yes             | no        | mean               | Z    |
| frequencyBodyAccelerometerJerkSDX           | frequency        | body        | accelerometer | yes             | no        | standard deviation | X    |
| frequencyBodyAccelerometerJerkSDY           | frequency        | body        | accelerometer | yes             | no        | standard deviation | Y    |
| frequencyBodyAccelerometerJerkSDZ           | frequency        | body        | accelerometer | yes             | no        | standard deviation | Z    |
| frequencyBodyGyroscopeMeanX                 | frequency        | body        | gyroscope     | no              | no        | mean               | X    |
| frequencyBodyGyroscopeMeanY                 | frequency        | body        | gyroscope     | no              | no        | mean               | Y    |
| frequencyBodyGyroscopeMeanZ                 | frequency        | body        | gyroscope     | no              | no        | mean               | Z    |
| frequencyBodyGyroscopeSDX                   | frequency        | body        | gyroscope     | no              | no        | standard deviation | X    |
| frequencyBodyGyroscopeSDY                   | frequency        | body        | gyroscope     | no              | no        | standard deviation | Y    |
| frequencyBodyGyroscopeSDZ                   | frequency        | body        | gyroscope     | no              | no        | standard deviation | Z    |
| frequencyBodyAccelerometerMagnitudeMean     | frequency        | body        | accelerometer | no              | yes       | mean               |      |
| frequencyBodyAccelerometerMagnitudeSD       | frequency        | body        | accelerometer | no              | yes       | standard deviation |      |
| frequencyBodyAccelerometerJerkMagnitudeMean | frequency        | body        | accelerometer | yes             | yes       | mean               |      |
| frequencyBodyAccelerometerJerkMagnitudeSD   | frequency        | body        | accelerometer | yes             | yes       | standard deviation |      |
| frequencyBodyGyroscopeMagnitudeMean         | frequency        | body        | gyroscope     | no              | yes       | mean               |      |
| frequencyBodyGyroscopeMagnitudeSD           | frequency        | body        | gyroscope     | no              | yes       | standard deviation |      |
| frequencyBodyGyroscopeJerkMagnitudeMean     | frequency        | body        | gyroscope     | yes             | yes       | mean               |      |
| frequencyBodyGyroscopeJerkMagnitudeSD       | frequency        | body        | gyroscope     | yes             | yes       | standard deviation |      |

## Summarized Output
The output, tidyData.txt, is written to the working directory. This table contains one row for each subject/activity/measurement combination with the value being the mean of the measurements for that group. This results in a total of 11,880 observations made up of 66 measurements taken from each of 30 subjects each performing 6 activities. 

This data can be viewed with the following code (note this assumes the file is in the working directory):

```{r}
data <- read.table("tidyData.txt",header=TRUE)
View(data)
```

## References
Anguita, D., Ghio, A., Oneto, L., Parra, X., & Reyes-Ortiz, J. L. (2013). *A Public Domain Dataset for Human Activity Recognition Using Smartphones* [Data set]. 21st European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning. [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

Hood, D. (2015, September 9). Getting and Cleaning the Assignment. *thoughtfulbloke aka David Hood*. [https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/)
