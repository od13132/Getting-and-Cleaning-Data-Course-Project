## Getting and Cleaning Data Course Project ##

# Purpose is to collect, work with, and clean a data set.

# Goal is to prepare tidy data that can be used for analysis.

# Overview: These data sets represent the data collected from the accelerometers
# from the Samsung Galaxy S Smartphone. See README.md for more details

################################################################################
## Preparing the project
################################################################################

# prepare workspace
setwd("C:/Users/Osian/Desktop/Data_Science/Projects/Getting and Cleaning Data")


# prepare packages
library(dplyr)


# download and unzip folder
if(!file.exists("dataset.zip")) {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        f <- file.path(getwd(), "dataset.zip")
        download.file(url, f)
        unzip("dataset.zip", exdir = getwd())
}


# fp stands for folder path
fp <- "UCI HAR Dataset"


# read train files
trainSubjects <- read.table(file.path(fp, "train", "subject_train.txt"))
trainValues <- read.table(file.path(fp, "train", "X_train.txt"))
trainActivity <- read.table(file.path(fp, "train", "y_train.txt"))

# read test files
testSubjects <- read.table(file.path(fp, "test", "subject_test.txt"))
testValues <- read.table(file.path(fp, "test", "X_test.txt"))
testActivity <- read.table(file.path(fp, "test", "Y_test.txt"))

# read features and labels
# note: as.is = TRUE is needed for features - column names are not unique
features <- read.table(file.path(fp, "features.txt") as.is = TRUE)
activityLabels <- read.table(file.path(fp, "activity_labels.txt"))


################################################################################
## Step 1: Merging data and assigning column names
################################################################################

# view and check tables - train datasets all have 7,352 entries comparing to 
# test datasets having 2,947 entries. Both are fine to bind.

# merge all data sets
combTrain <- cbind(trainSubjects, trainActivity, trainValues)
combTest <- cbind(testSubjects, testActivity, testValues)


mainActivity <- rbind(combTrain, combTest)


# Set column names - need second column of features table
colnames(mainActivity) <- c("Subject", "Activity", features[,2])


################################################################################
## Step 2: Extract only the measurements on the mean and sd
################################################################################

# Need to extract column names with mean() and std()
extract <- grepl("Subject|Activity|mean|std", colnames(mainActivity))


# Subsetting data
mainActivity <- mainActivity[, extract]


################################################################################
## Step 3: Use descriptive activity names to name the activities
################################################################################

# replace activity values with labels
mainActivity$Activity <- factor(mainActivity$Activity, 
                                levels = activityLabels[,1], 
                                labels = activityLabels[,2])


################################################################################
## Step 4: Label the data set with descriptive variable names
################################################################################

mainActivityName <- colnames(mainActivity)


# expand names for easier understandment
mainActivityName <- gsub("^t", "Time", mainActivityName)
mainActivityName <- gsub("^f", "Frequency", mainActivityName)


# correct typo "BodyBody"
mainActivityName <- gsub("BodyBody", "Body", mainActivityName)


# update labels
colnames(mainActivity) <- mainActivityName


################################################################################
## Step 5: Create a 2nd data set with average of each variable
################################################################################

# group by subject and activity
mainActivityMeans <- mainActivity %>%
        group_by(subject, Activity) %>%
        summarise_each(funs(mean))


# export to file
write.table(mainActivityMeans, "tidyMeanData.txt", row.names = FALSE,
            quote = FALSE)
