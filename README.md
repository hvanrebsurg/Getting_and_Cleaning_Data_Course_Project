#Getting and Cleaning Data
##Course Project
###Heinrich van Rensburg
###23/08/2015

This is a repo for the submission of the Getting and Cleaning Data course project.

##Overview

This project aims to demonstrate the ability to get and clean a data set that can be used for further analysis at a later stage.

The data used can be found at the following link:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    
##Project Summary

This section summarises the requirements of the project.

Create a R script run_analysis.R that can be used to do the following:
-Merges the training and the test sets to create one data set.
-Extracts only the measurements on the mean and standard deviation for each measurement. 
-Uses descriptive activity names to name the activities in the data set
-Appropriately labels the data set with descriptive variable names. 
-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##The Script

In order to run the script, only the line used to set the working directory (Line 22) will need to be changed to a directory chosen by the user.

The script has been written in a way that will download and unzip the data from the URL provided above. The script is coded and follows the five (5) steps required to obtain the cleansed data set as mentioned in the Project Summary.

If any additional information about the variables or data transformations is required, please refer to the CodeBook.md file.
