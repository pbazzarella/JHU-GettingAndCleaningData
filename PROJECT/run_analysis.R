########################################################################
# Getting and Cleaning Data Course Project
# NAME: PEDRO BAZZARELLA DA SILVA
# COURSE ID: GETDATA-032
# cODE VERSION: V1 
########################################################################

# [ STEP 01 ] - LIBRARIES ##########################################

library(reshape2)
library(dplyr)
library(data.table)

# [ STEP 02 ] - TEST DIRECTORY #####################################

getwd()
if(!file.exists("data")) {
  dir.create("data")
}


# [ STEP 03] - DOWNLOAD FILE #######################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
#setInternet2(use = TRUE)
download.file(fileUrl, destfile = "./data/gcd_project.zip", mode="wb")
unzip("./data/gcd_project.zip",exdir = "./data" )
#help(unzip)



# [ STEP 04 ] - DATA LOAD ##########################################

# 4.1 - Data Load (FEATURES)
featuresN <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = F)[,2]

# 4.2 - Data Load (ACTIVITIES)
activityN <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


# 4.3 - Prepare measure names (MEAN and STANDARD DEVIATION)
subjectsCN <- c("subjects")
activitiesCN <- c("activities")
filterdate <- c(subjectsCN, activitiesCN,
                featuresN[grepl("mean()", featuresN, fixed=TRUE)],
                featuresN[grepl("std()", featuresN, fixed=TRUE)]
)


# 4.4 Prepare the TEST DATA
subjectTest <- read.table('./data/UCI HAR Dataset/test/subject_test.txt', col.names=subjectsCN)
activitiesTest <- read.table('./data/UCI HAR Dataset/test/y_test.txt', col.names=activitiesCN)
featuresTest <- read.table('./data/UCI HAR Dataset/test/X_test.txt', col.names=featuresN, check.names = FALSE)
testData <- cbind(subjectTest, activitiesTest, featuresTest)


# 4.5 Prepare the TRAIN DATA
subjectTrain <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', col.names=subjectsCN)
activitiesTrain <- read.table('./data/UCI HAR Dataset/train/y_train.txt', col.names=activitiesCN)
featuresTrain <- read.table('./data/UCI HAR Dataset/train/X_train.txt', col.names=featuresN, check.names = FALSE)
trainData <- cbind(subjectTrain, activitiesTrain, featuresTrain)


# [ STEP 05] - DATA TRANSFORMATION #################################

# 5.1 - Merge the TEST and TRAIN data
mergeData <- rbind(trainData, testData)
head(mergeData,10)

# 5.2 - Extract mean and standard-deviation based on filterdate
tempData <- mergeData[, filterdate]
head(tempData,10)


# 5.3 - Get tidy data - required in step 5
tidyData <- group_by(tidyData,subjects, activities) 
tidyData <- summarise_each(tidyData,funs(mean)) 
  print(tidyData)
#View(tidyData)


# 5.4 - Set Names to ACTIVITIES [tidyData$activities]
tidyData$activities <-factor(tidyData$activities, labels = activityN$V2)
#tidyData$subjects   <-factor(tidyData$subjects,   labels = subjectsCN)
print(tidyData)
View(tidyData)


# [ STEP 06] - EXPORT TIDY DATA TO FILE ############################

# 6.1 - Export the tidydata to file (tidydata.txt)
write.table(tidyData, file = "./data/tidydata.txt", row.names = FALSE)

