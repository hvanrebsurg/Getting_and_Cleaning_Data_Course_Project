#Getting and Cleaning Data
##Course Project
###Heinrich van Rensburg
###23/08/2015

##Introduction

This code book aims to provide information regarding the data, variables and cleansing actions performed in the Getting and Cleaning Data course project.

##Source Data

The data used in the completion of this project can be found at the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It is however not necessary to download and unzip the data before running the R script as these actions are included in the initial steps of the script.

##Dataset Information

An explanation of the data can be found in the README.txt file included in the dataset downloaded from the link mentioned above. The introduction to the dataset is as follows:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

##Attributes

Each of the records in the dataset have been allocated the following attributes:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope 
- A 561-feature vector with time and frequency domain variables 
- Its activity label
- An identifier of the subject who carried out the experiment

##Step 0: Extract and unzip the the dataset 

The first step, labelled as Step 0 as it precedes the first requirement of the assignment, performs the following.

-Set your working directory
-Store the URL at which the data is downloaded
-Check if the file has been dowloaded before commencing download
-Unzip the downloaded file
-View the files that are in the Dataset folder

##Step 1: Import and merge the dataset

In this step the datasets are read into R, after which the variable names are assigned to the columns and finally the datasets are merged to create one final dataset.

###Import the datasets
-Features
-Activity_Labels
-X_Train
-Y_Train
-Subject_Train
-X_Test
-Y_Test
-Subject_Test

### Assign variable names to the columns

The variable names are assigned using the Features dataset as well as the assigning of the names Activity_ID and Activity_Type to the relevant variables.

###Mering the datasets

The datasets are merged in order to obtain the final dataset. This is done by first merging the train and test data seperately, after which these two datasets are merged in the final step.

##Step 2: Extract the measurements on the mean and standard deviation for each measurement

This step is performed by:
-Creating a vector of the column names that can be used to extract only the correct columns
-Creating a logical vector using the the vector previouslt created to only select the columns required
-Output the dataset to only contain the columns that are True in the logical vector

##Step 3: Uses descriptive activity names to name the activities in the data set

This step is performed by merging in the Activity_Labels dataset to get the activity names into the dataset.

##Step 4: Appropriately label the data set with descriptive variable names

This step is completed by performing the following:
-Update the Col_Name vetor to include the newly merged in field
-Clean up the variable names to make the headings mor descriptive
-Re-assign the updated column names to the dataset.

##Step 5: Create a second tidy data set with the average of each variable for each activity and each subject

The final step in the assignment is completed as follows:
-Create a seperate data set for the final output
-Create the final output with the average of each variable per activity and subject combination

