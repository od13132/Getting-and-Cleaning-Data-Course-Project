---
# CodeBook


## Introduction

This code book describes the process of making and explains the variables associated with the 'tidyMeanData.txt' in this repository. See the 'README.md' file for background information on this data set.

The data was retrieved as a zip file from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The zip file contained many text files of which a total of 8 files were used on R for cleaning and manipulating. These files were:

- features.txt

- activity_labels.txt

- subject_train.txt

- X_train.txt

- y_train.txt

- subject_test.txt

- X_test.txt

- y_test.txt

## The Variables

- Subject = test subject's ID

- Activity = the type of activity performed

- tBodyAcc-XYZ

- GravityAcc-XYZ

- tBodyAccJerk-XYZ

- tBodyGyro-XYZ

- tBodyGyroJerk-XYZ

- tBodyAccMag

- tGravityAccMag

- tBodyAccJerkMag

- tBodyGyroMag

- tBodyGyroJerkMag

- fBodyAcc-XYZ

- fBodyAccJerk-XYZ

- fBodyGyro-XYZ

- fBodyAccMag

- fBodyAccJerkMag

- fBodyGyroMag

- fBodyGyroJerkMag

### Description of abbreviations of measurements

- Body = body movement

- Acc = accelerometer measurement

- Gyro = gyroscopic measurement

- Jerk = sudden movement acceleration

- Mag = magnitude of movement

- Mean and std are calculated for each subject for each activity for each mean and std measurements

- X Y Z = denotes the 3-axial directions. 

The units given are: g for the accelerometer; rad/sec for the gyro; g/sec and rad/sec/sec for the corresponding jerks.

## The Procedure

The aim is to download, clean and manipulate the data set in preparation for analysis. Please see 'run_analysis.md' for the code.  

### Prepare the workspace

- Loaded package - dplyr

- Downloaded the zip file and extract it in the working directory.

- Read the files (listed above)

### Step 1: Merging the data

- Used cbind and rbind to merge all data

- Set column names for the new table using 'features.txt'

### Step 2: Extract measurements on mean and sd

- Subset the data using grepl function to determine all variables with mean and sd

### Step 3: Use descriptive activity names to name the activities

- Replaced numeric values under Activity using 'activity_labels.txt'

### Step 4: Label the data set with descriptive variable names

- Expanded t into Time and F into Frequency in the column names

- Corrected a typo - from "BodyBody" to "Body"

### Step 5: Create a 2nd data set with average of each variable

- Grouped by subject and activity

- Exported the new tidy dataset


