########################################################################
# Getting and Cleaning Data Course Project
# NAME: PEDRO BAZZARELLA DA SILVA
# COURSE ID: GETDATA-032
########################################################################

# [ STEP 01 ] - LIBRARIES --------------------------------
library(reshape2)
library(dplyr)
library(data.table)

# [ STEP 02 ] - TEST DIRECTORY ---------------------------
getwd()

if(!file.exists("data")) {
  dir.create("data")
}


# [ STEP 03] - DOWNLOAD FILE -----------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
#setInternet2(use = TRUE)
download.file(fileUrl, destfile = "./data/gcd_project.zip", mode="wb")
unzip("./data/gcd_project.zip",exdir = "./data" )
#help(unzip)

# [ STEP 04 ] - DATA LOAD --------------------------------
# TEST DATA
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt") 
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt") 
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# TRAIN DATA
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt") 
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

# FEATURES
features <- read.table("./data/UCI HAR Dataset/features.txt")

# ACTIVITIES
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# MERGE DATA
dataMerge <- rbind(testX, trainX)
labelMerge <- rbind(testY, trainY)
subjectMerge <- rbind(testSubject, trainSubject)


# [ STEP 05 ] - DATA ETL (EXTRACT MEASURES) --------------
# ADD NAMES TO DATA
names(dataMerge) <- features$V2
# Name the variable as 'Activity' and merge to the final data set
colnames(labelMerge) <- c('Activity')
dataMerge <- bind_cols(dataMerge, labelMerge)

# Bind the subjects to the final data set
colnames(subjectMerge) <- c('Subject')
dataMerge <- bind_cols(dataMerge, subjectMerge)

# Mean and Standard Deviation for each measurement 
dataMerge <- select(dataMerge, contains('mean'), contains('std'))

# Create a summary data set grouped by Subject and Activity
dataGroup <- group_by(dataMerge, Subject, Activity)
tidydata <- summarise_each(dataGroup, funs(mean))

## Write the Summary Data to a text file
write.table(tidydata, file = "./data/tidydata.txt", row.names = FALSE)

