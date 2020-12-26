# DataCleaningProject
 Course Project for Getting ang Cleaning Data

==================================================================
The data in this dataset are derived from:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The original experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

 Each original record provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

This (new) dataset provides:
=========================================

- Averages for the mean and standard deviation of each varaible reported in the original data set grouped by activty and test subject.

The dataset includes the following files:
=========================================

-README.md
-CodeBook.md : provides information on each variable in the dataset
-run_analysis.R : contains code to process the data from the orignal dataset and returns the new dataset described above

How run_analysis.R works:
=========================================

  Creates LoadFrame function for loading the test and trial data.  Requires file locations for subject numbers, activity numbers, and test/training data (in that order).  Output is a tibble that includes subject number, activity name, and data on all variables.

  Reads in the variable names from the original data set and extracts those that are a calculated mean or standard deviation.

  Defines file locations to input to LoadFrame to obtain test data.  (If working directory contains the UCI HAR Dataset folder, these file paths should be correct.)

  Loads the test dataset.

  Defines file locations to input to LoadFrame to obtain training data.  (If working directory contains the UCI HAR Dataset folder, these file paths should be correct.)

  Loads the training dataset.

  Combines test and training data into one complete dataset with data for all test subjects.

  Revises variable names to meake them more descriptive.

  Group data by subject and activity, then find the mean for each combination of those variables.

  Output data to text file.