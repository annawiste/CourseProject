---
title: "Codebook"
date: 6/21/15
output: html_document
---

Project:
Course Project for Getting and Cleaning Data

Study Design, Data Collection: 
as described in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Human Activity Recognition Using Smartphones Dataset Version 1.0
Briefly, there were 30 subjects, each wearing a smartphone at the waist while doing 6 activities (Sitting, Standing, Laying, Walking, Walking Upstairs, Walking Downstairs). Measurements were taken from the phones accelerometer and gyroscope. Thus acceleration and velocity in x, y, and z directions were captured.

Generating dataset final.txt from raw data:
Download data using provided url.
View README to familiarize with components of data
Attach matching subject and activity columns to training and testing sets
Merge training and testing sets
Created data frame with variable numbers and matching feature names for features reflecting mean and std of each measurement.
Extracted desired columns from main dataset using column 1 of data frame
Applied appropriate descriptive column name using column 2
Added Activity names in place of numbers
Grouped data on 2 levels and summarized, generating mean value for each subject doing each activity. 1 value per subject-activity combination.

Variables in dataset
Dataset consists of 180 observations on 68 variables.

Variable    
Subject   class-integer, range-1:30
Activity  class-character, 6 possibilities-"LAYING" "SITTING" "STANDING" "WALKING" "WALKING-UPSTAIRS" "WALKING-DOWNSTAIRS"

Measurement variables - 
There are a total  of 66 measurement variables in this dataset, derived as follows.
All are derived from the 2 initial measurements tAcc (t-time, Acc-accelerometer) and tGyro (t-time, Gyro-gyroscope). tAcc is split into Gravity and Body, and for the Body Acc and Gyro, Jerk signals are derived.
There are now 5 measurements:
tBodyAcc
tGravityAcc
tBodyAccJerk
tBodyGyro
tBodyGyroJerk
Each of these is present in 3 axial components (X,Y,Z) (total of 15 variables)

An additional single variable includes the magnitude of the 3 axial variables. 
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tbodyGyroMag
tbodyGyroJerkMag

Additionally there is a fast fourier transformation of some variables
-Three with axial components-
fBodyAcc
fBodyAccJerk
fBodyGyro

-Four without axial, mean and std of each-
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

For these 33 measurements, the mean and standard deviation features were extracted from the larger dataset, yielding 66 variables

There are many observations for each Subject-Activity pair in the starting dataset.
The current dataset includes 180 observations, 1 for each subject(30)and activity(6) pair. To do this all observations for each Subject-Activity pair were averaged. 




Data Accessed: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Descriptions of data generated from 'features_info.txt' included in download and from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
