getting-and-cleaning-data-project
README.md

#######################################################################
# Getting and Cleaning Data Course Project
# NAME: PEDRO BAZZARELLA DA SILVA
# COURSE ID: GETDATA-032
# cODE VERSION: V1 
########################################################################

Files contained in this repo:

README.md
run_analysis.R
tidydata.txt


The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Execution

It runs from the top level directory containing folder "HCI HAR Dataset" - Note that the working directory must be set on line 14 with an absolute path to the top level directory mentioned. For example, if the path to the mentioned folder is "C:/my_folder/HCI HAR Dataset", then the working dir to be set should be "C:/my_folder/"

The script assumes it has in it's working directory the following files and folders

HCI HAR Dataset/ activity_labels.txt
HCI HAR Dataset/ features.txt
HCI HAR Dataset/ test/
HCI HAR Dataset/ train/
The output is created in working directory with the name of tidy2.txt

CodeBook

Details regarding the variables used from the data set & their measurement units can be found in the CodeBook.md file contained in this repository.

What the code does

Transformation

In order to obtain a tidy data set, the following was performed:

# [ STEP 01 ] - LIBRARIES
# 1.1 - Load Libraries

# [ STEP 02 ] - TEST DIRECTORY
# 2.1 - Test the directory to put the file

# [ STEP 03] - DOWNLOAD FILE
# 3.1 - Download the File

# [ STEP 04 ] - DATA LOAD
# 4.1 - Data Load (FEATURES)
# 4.2 - Data Load (ACTIVITIES)
# 4.3 - Prepare measure names (MEAN and STANDARD DEVIATION)
# 4.4 Prepare the TEST DATA
# 4.5 Prepare the TRAIN DATA

# [ STEP 05] - DATA TRANSFORMATION

# 5.1 - Merge the TEST and TRAIN data
# 5.2 - Extract mean and standard-deviation based on filterdate
# 5.3 - Get tidy data - required in step 5
# 5.4 - Set Names to ACTIVITIES [tidyData$activities]

# [ STEP 06] - EXPORT TIDY DATA TO FILE
# 6.1 - Export the tidydata to file (tidydata.txt)

Note that this information is also present in CodeBook.md
