# Code book for Coursera project of "Getting and Cleaning Data" course
This code book describes the variables, the data, and all transformations performed to clean up the orinignal data set to create tidy data set used to create `tidy_data.txt` file of this repository.
See the README.md file of this repository for details about original data set.

## Data
The tidy_data.txt file is a text file containing space-separated values.
First row contains the labels of the variables, which are listed and described in the Variables section below, and the following rows contain the observation values for each variables.
2 first columns contains subjects and activities identifiers described in the Variables section below.

## Variables
Each row is a set of measures for a given subject and activity.

### Identifiers
* `subject`: an identifier of the subject who carried out the experiment.
* `activityLabel`: one of the  six activities perfomed byt the subject. Possible values are: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.


### Measures
All features are normalized and bounded within [-1,1].
Each feature vector is a row on the text file.

#### Original data 
The features selected for this database come from the accelerometer (measures with `Acc` in the label) and gyroscope 3-axial (measures with `Gyro` in the label) raw signals from the phone.
These time domain signals (prefix `time`) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (measures with `Body` or `Gravity` in the label) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (measures with `Jerk` in the label). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (measures with `Mag` in the label). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals (measures with `Freq` in the label).

Only orginal features used in the transformation process are mean and standard deviation values (with `mean` or `std` as label suffix).

#### Tidy data
All data provided in the `tidy_data.txt` file of this repository are average of each variable for each activity and each subject (so prefix is avg).

All data labels are build on the following patter : 
avg\<Time or Freq\>\<Body or Gravity\>\<Acc or Gyro\>\<empty or Mag or Jerk\>\<Mean or Std\>\<X or Y or Z\> (exemple avgTimeBodyGyroJerkStdX):
* avg: average measures for this subject and this acticity (all measures in text file are average)
* \<Time or Freq\>: time or frequency domain signal
* \<Body or Gravity\>: body or gravity acceleration
* \<Acc or Gyro\> : accelerometer or gyroscope 3-axial measures
* \<empty or Mag or Jerk\>: nothing, jerk or magnitude process
* \<Mean or Std\>:  mean or standard deviation measures
* \<X or Y or Z\>: axis of the measure (if relevant, otherwise nothing)

List of measures : 
* avgTimeBodyAccMeanX
* avgTimeBodyAccMeanY
* avgTimeBodyAccMeanZ
* avgTimeBodyAccStdX
* avgTimeBodyAccStdY
* avgTimeBodyAccStdZ
* avgTimeGravityAccMeanX
* avgTimeGravityAccMeanY
* avgTimeGravityAccMeanZ
* avgTimeGravityAccStdX
* avgTimeGravityAccStdY
* avgTimeGravityAccStdZ
* avgTimeBodyAccJerkMeanX
* avgTimeBodyAccJerkMeanY
* avgTimeBodyAccJerkMeanZ
* avgTimeBodyAccJerkStdX
* avgTimeBodyAccJerkStdY
* avgTimeBodyAccJerkStdZ
* avgTimeBodyGyroMeanX
* avgTimeBodyGyroMeanY
* avgTimeBodyGyroMeanZ
* avgTimeBodyGyroStdX
* avgTimeBodyGyroStdY
* avgTimeBodyGyroStdZ
* avgTimeBodyGyroJerkMeanX
* avgTimeBodyGyroJerkMeanY
* avgTimeBodyGyroJerkMeanZ
* avgTimeBodyGyroJerkStdX
* avgTimeBodyGyroJerkStdY
* avgTimeBodyGyroJerkStdZ
* avgTimeBodyAccMagMean
* avgTimeBodyAccMagStd
* avgTimeGravityAccMagMean
* avgTimeGravityAccMagStd
* avgTimeBodyAccJerkMagMean
* avgTimeBodyAccJerkMagStd
* avgTimeBodyGyroMagMean
* avgTimeBodyGyroMagStd
* avgTimeBodyGyroJerkMagMean
* avgTimeBodyGyroJerkMagStd
* avgFreqBodyAccMeanX
* avgFreqBodyAccMeanY
* avgFreqBodyAccMeanZ
* avgFreqBodyAccStdX
* avgFreqBodyAccStdY
* avgFreqBodyAccStdZ
* avgFreqBodyAccJerkMeanX
* avgFreqBodyAccJerkMeanY
* avgFreqBodyAccJerkMeanZ
* avgFreqBodyAccJerkStdX
* avgFreqBodyAccJerkStdY
* avgFreqBodyAccJerkStdZ
* avgFreqBodyGyroMeanX
* avgFreqBodyGyroMeanY
* avgFreqBodyGyroMeanZ
* avgFreqBodyGyroStdX
* avgFreqBodyGyroStdY
* avgFreqBodyGyroStdZ
* avgFreqBodyAccMagMean
* avgFreqBodyAccMagStd
* avgFreqBodyAccJerkMagMean
* avgFreqBodyAccJerkMagStd
* avgFreqBodyGyroMagMean
* avgFreqBodyGyroMagStd
* avgFreqBodyGyroJerkMagMean
* avgFreqBodyGyroJerkMagStd

## Transformations performed on original data set
Foolowing process has been applied to calulate tydi data in text file:
* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean and standard deviation for each measurement
* Uses descriptive activity names to name the activities in the data set (removin`(`, `)`, `-`, duplicate words...)
* Appropriately labels the data set with descriptive variable names
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Result of last step is wrote in the `tidy_data.txt` file of this repository.
