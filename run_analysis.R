## This script has been built to prepare tidy data from the 'Human Activity
## Recognition Using Smartphones Data Set' provided by UCI
## It does the following:
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement.
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names.
## 5) From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## Load specific library used in the script 
library(dplyr)

## Store zip file name into variable
zipFile <- "FUCI HAR Dataset.zip"

## Check if zip file already exists
## If not, donwload it
if(!file.exists(zipFile)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = zipFile, method = "curl")
}

## Unzip the file into working directory (even if not downloaded to ensure
## data consistency)
unzip(zipFile, overwrite=TRUE)

## Load all useful files into data.table variables
## Add column names when necessary
dataTestX <- fread("UCI HAR Dataset/test/X_test.txt", header = FALSE)
dataTestY <- fread("UCI HAR Dataset/test/y_test.txt", header = FALSE) %>% setnames(c("activityID"))
dataTestSubject <- fread("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
dataTrainX <- fread("UCI HAR Dataset/train/X_train.txt", header = FALSE)
dataTrainY <- fread("UCI HAR Dataset/train/y_train.txt", header = FALSE) %>% setnames(c("activityID"))
dataTrainSubject <- fread("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
dataActivityLabels <- fread("UCI HAR Dataset/activity_labels.txt", header = FALSE) %>% setnames(c("activityID", "activityLabel"))
dataFeatures <- fread("UCI HAR Dataset/features.txt", header = FALSE, select=c(2)) %>% setnames(c("featureLabel"))

## Add activities labels to 2 activities variables by using activities id as pivot
dataTestY<- left_join(dataTestY, dataActivityLabels, by="activityID")
dataTrainY<- left_join(dataTrainY, dataActivityLabels, by="activityID")

## Add 3 columns with subjects ids, activities ids and labels to 2 sets of observation 
dataTestX <- cbind(dataTestSubject, dataTestY, dataTestX)        
dataTrainX <- cbind(dataTrainSubject, dataTrainY, dataTrainX)

## Merge the 2 sets of observation in a global set
allData <- rbind(dataTestX, dataTrainX)

## Edit set of observations labels by 
## - Ensuring names are unique (duplicate names in original data)
## - Adding these labels to global set of observation 
dataFeatures$featureLabel <-  make.unique(dataFeatures$featureLabel)
names(allData) <- c("subject", "activityID", "activityLabel", dataFeatures$featureLabel)

## Identify in the global set of observation, all measures which are mean and
## standard deviation by filtering on measures labels. result is a boolean vector
## on which data 1 and 3 are set to TRUE to ensure columns with subjects ids 
## and activities labels will not be removed
measureSelection <- grepl("mean\\(\\)|std\\(\\)", names(allData), ignore.case = TRUE)
measureSelection[1] <- TRUE
measureSelection[3] <- TRUE

## Apply previous boolean vector in susbetting  global set of observation to select
## only useful variables and observations for the project
filteredData <- allData[,measureSelection,with=FALSE]

## Clean observation labels by removing (,),- characters, adding capital to first
## character of Mean and Std, tranforming t and f values (for time and frequency)
## with label et removing duplicates "body" word 
names(filteredData) <- gsub("^t", "time",names(filteredData))
names(filteredData) <- gsub("^f", "freq",names(filteredData))
names(filteredData) <- gsub("\\(\\)", "",names(filteredData))
names(filteredData) <- gsub("-", "",names(filteredData))
names(filteredData) <- gsub("mean", "Mean",names(filteredData))
names(filteredData) <- gsub("std", "Std",names(filteredData))
names(filteredData) <- gsub("BodyBody", "Body",names(filteredData))

## Create new tidy data set with the average of each variable for each activity 
## and each subject 
filteredDataMeans <- filteredData %>% group_by(subject, activityLabel) %>% summarize_all(funs(mean))

## Adapt observations labels with "avg" word at the beginning of each label 
names(filteredDataMeans) <- gsub("^t", "avgT",names(filteredDataMeans))
names(filteredDataMeans) <- gsub("^f", "avgF",names(filteredDataMeans))

## Write tidy data set of average values into text file
write.table(filteredDataMeans, file = "tidy_data.txt",row.names = FALSE)
