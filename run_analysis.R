################################################################################################################################## 
#                                 Coursera - Getting and Cleaning Data Course Project                                            #
#  Author:      H van Rensburg                                                                                                   #
#  Date:        19/08/2015                                                                                                       #
#  Platform:    Rstudio Version 0.98.1103   (Windows 8)                                                                          #
#--------------------------------------------------------------------------------------------------------------------------------#
#                                               Steps Followed                                                                   #
#  Step 0: Extract and unzip the the dataset                                                                                     #
#  Step 1: Import and merge the dataset                                                                                          #
#  Step 2: Extract the measurements on the mean and standard deviation for each measurement                                      #
#  Step 3: Uses descriptive activity names to name the activities in the data set                                                #
#  Step 4: Appropriately label the data set with descriptive variable names                                                      #
#  Step 5: Create a second tidy data set with the average of each variable for each activity and each subject                    #
#                                                                                                                                #
################################################################################################################################## 


#-------------------------------------------------------------------------------------------------------------#
## Step 0: Extract and unzip the the dataset                                                                 ##
#-------------------------------------------------------------------------------------------------------------#
        # Set your working directory
setwd("./R/WD")

        # Store the URL at which the data is downloaded
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


        # Check if the file has been dowloaded before commencing download
if(!file.exists("./data")){
        dir.create("./data")
    }
if(!file.exists("./data/Dataset.zip")){
        download.file(fileURL,destfile="./data/Dataset.zip",mode = 'wb')
}
        # Unzip the downloaded file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

        # View the files that are in the Dataset folder
path_Folder <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_Folder, recursive=TRUE)
files


#-------------------------------------------------------------------------------------------------------------#
## Step 1: Import and merge the dataset                                                                      ##
#-------------------------------------------------------------------------------------------------------------#
        # Import the datasets
   
setwd("./data/UCI HAR Dataset")                                                     # Set the working directory to the where the dataset is stored

        # Import the datasets
Features            <- read.table("./features.txt", header = FALSE)                 # Import the Features Data
Activity_Labels     <- read.table("./activity_labels.txt", header = FALSE)          # Import the Activity Labels Data

X_Train             <- read.table("./train/X_train.txt", header = FALSE)            # Import the X_train Data
Y_Train             <- read.table("./train/y_train.txt", header = FALSE)            # Import the y_train Data
Subject_Train       <- read.table("./train/subject_train.txt", header = FALSE)      # Import the subject_train Data

X_Test              <- read.table("./test/X_test.txt", header = FALSE)              # Import the X_test Data
Y_Test              <- read.table("./test/y_test.txt", header = FALSE)              # Import the y_test Data
Subject_Test        <- read.table("./test/subject_test.txt", header = FALSE)        # Import the subject_test Data

        # Assign variable names to the columns
colnames(Activity_Labels)    <- c("Activity_ID","Activity_Type");                   # Assign column headers to the Activity_Labels Data

colnames(X_Train)           <- Features[,2];                                        # Assign column headers to the X_Train Data
colnames(Y_Train)           <- "Activity_ID";                                       # Assign column headers to the Y_Train Data
colnames(Subject_Train)     <- "Subject_ID";                                        # Assign column headers to the Subject_Train Data

colnames(X_Test)            <- Features[,2];                                        # Assign column headers to the X_Test Data
colnames(Y_Test)            <- "Activity_ID";                                       # Assign column headers to the Y_Test Data
colnames(Subject_Test)      <- "Subject_ID";                                        # Assign column headers to the Subject_Test Data

        # Create the merged data sets for the Train and Test data

Data_Train          <- cbind(Subject_Train,X_Train,Y_Train);
Data_Test           <- cbind(Subject_Test,X_Test,Y_Test);

        # Create the final data set by merging the Test and Training data sets

Data_Final          <- rbind(Data_Train,Data_Test);



#-------------------------------------------------------------------------------------------------------------#
## Step 2: Extract the measurements on the mean and standard deviation for each measurement                  ##
#-------------------------------------------------------------------------------------------------------------#
        # Create a vector of the column names that can be used to extract only the correct columns
Col_Name <- colnames(Data_Final);

        # Create a logical vector using the the vector previouslt created to only select the columns required
Col_Name_Logical <- (grepl("Activity_ID",Col_Name) | grepl("Subject_ID",Col_Name) | grepl("-mean..",Col_Name) & !grepl("-meanFreq..",Col_Name) & !grepl("mean..-",Col_Name) | grepl("-std..",Col_Name) & !grepl("-std()..-",Col_Name));
       
        # Output the dataset to only contain the columns that are True in the logical vector
Data_Final <- Data_Final[Col_Name_Logical==TRUE]

#-------------------------------------------------------------------------------------------------------------#
## Step 3: Uses descriptive activity names to name the activities in the data set                            ##
#-------------------------------------------------------------------------------------------------------------#
        # Merge in the Activity_Labels dataset to get the activity names into the dataset
Data_Final <- merge(Data_Final,Activity_Labels,by='Activity_ID',all.x=TRUE);



#-------------------------------------------------------------------------------------------------------------#
## Step 4: Appropriately label the data set with descriptive variable names                                  ##
#-------------------------------------------------------------------------------------------------------------#
        # Update the Col_Name vetor to include the newly merged in field
Col_Name <- colnames(Data_Final);

        # Clean up the variable names to make the headings mor descriptive
for (i in 1:length(Col_Name)) 
    {
        Col_Name[i] <- gsub("\\()","",Col_Name[i])
        Col_Name[i] <- gsub("-std$","StdDev",Col_Name[i])
        Col_Name[i] <- gsub("-mean","Mean",Col_Name[i])
        Col_Name[i] <- gsub("^(t)","Time_",Col_Name[i])
        Col_Name[i] <- gsub("^(f)","Freq_",Col_Name[i])
        Col_Name[i] <- gsub("([Gg]ravity)","Gravity_",Col_Name[i])
        Col_Name[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body_",Col_Name[i])
        Col_Name[i] <- gsub("[Gg]yro","Gyro_",Col_Name[i])
        Col_Name[i] <- gsub("AccMag","Acc_Magnitude_",Col_Name[i])
        Col_Name[i] <- gsub("([Bb]odyaccjerkmag)","Body_Acc_Jerk_Magnitude_",Col_Name[i])
        Col_Name[i] <- gsub("JerkMag","Jerk_Magnitude_",Col_Name[i])
        Col_Name[i] <- gsub("GyroMag","Gyro_Magnitude_",Col_Name[i])
    };

        # Re-assign the updated column names to the data set
colnames(Data_Final) <- Col_Name;

#-------------------------------------------------------------------------------------------------------------#
## Step 5: Create a second tidy data set with the average of each variable for each activity and each subject##
#-------------------------------------------------------------------------------------------------------------#
        # Create a seperate data set for the final output
Data_Final_Activity_Type  <- Data_Final;

        # Create the final output with the average of each variable per activity and subject combination
Data_Final_Activity_Type    <- aggregate(Data_Final_Activity_Type[,names(Data_Final_Activity_Type) != c('Activity_ID','Subject_ID','Activity_Type')],
                                by=list(Activity_Type = Data_Final_Activity_Type$Activity_Type,Activity_ID=Data_Final_Activity_Type$Activity_ID,
                                        Subject_ID = Data_Final_Activity_Type$Subject_ID),mean);

