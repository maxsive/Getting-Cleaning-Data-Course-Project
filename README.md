# Getting & Cleaning Data: Course Project
## Project Stated Objectives
>1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Step One: Merge Training & Test Sets
1. Combine files for test data set:
    - Use the read.table() function and tbl_df {dplyr} to load in the "subject_test.txt" and name the column "subject"
    - Use the read.table() function and tbl_df {dplyr} to load in the "y_test.txt" and name the column "label"
    - Use the read.table() function and tbl_df {dplyr} to load in the "X_test.txt" and name the column "label"
    - Use bind_cols() {dplyr} to combine the test data sets
2. Combine files for train data set:
    - Use the read.table() function and tbl_df {dplyr} to load in the "subject_train.txt" and name the column "subject"
    - Use the read.table() function and tbl_df {dplyr} to load in the "y_train.txt" and name the column "label"
    - Use the read.table() function and tbl_df {dplyr} to load in the "X_train.txt" and name the column "label"
    - Use bind_cols() {dplyr} to combine the train data sets
3. Use bind_rows() {dplyr} to combine the test and train data sets.


## Step Two: Extract Mean & Standard Deviation 
1. Read in the "features.txt" file
2. Utlize the *grep* function to isolate the features that include the terms: "mean" and "std" for mean and standard deviation, respectively
3. Use the select {dplyr} function to exctract only the variables needed

## Step Three: Name Activities
1. Read in "activity_labels.txt" file to obtain descriptive labels
2. Coerce activity data to factor using as.factor()
3. Use levels() to rename the activity factor levels to descriptive

## Step Four: Label Data Set
1. Recall the list of features involving mean and std from Step Two
2. Extract the descriptive names from features.txt and coerce to character vector
3. Use colnames() to rename the variables (columns) in the dataset

## Step Five: Create Tidy Dataset
1. Use group_by {dplyr} to to group data by subject and activity
2. Use summarise {dplyr} to produce the desired dataset of mean values
3. Write a file using write.table() called analysis.txt with the tidy data set


