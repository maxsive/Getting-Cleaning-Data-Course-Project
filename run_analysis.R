run_analysis <- function() {
      
      ##-------Part 1----------------------------------------------------------
      ## Merges the training and the test sets to create one data set.
      ##-----------------------------------------------------------------------
      
      ##load required packages
      library(dplyr)
      
      ##load files to combine with dplyr bind_cols()
      ##for test set 
      test_subjects <- tbl_df(read.table("./test/subject_test.txt"))
      colnames(test_subjects)<-c("subject")
      
      test_activities <- tbl_df(read.table("./test/y_test.txt"))
      colnames(test_activities)<-c("activity")
      
      test_features <- tbl_df(read.table("./test/X_test.txt"))
      
      test_all <- bind_cols(test_subjects,test_activities,test_features)
      
      ##discard unrequired variables
      rm("test_activities"); rm("test_subjects"); rm("test_features")
      
      ##load files to combine with dplyr bind_cols()
      ##for test set       
      train_subjects <- tbl_df(read.table("./train/subject_train.txt"))
      colnames(train_subjects)<-c("subject")
      
      train_activities <- tbl_df(read.table("./train/y_train.txt"))
      colnames(train_activities)<-c("activity")
      
      train_features <- tbl_df(read.table("./train/X_train.txt"))
      
      train_all <- bind_cols(train_subjects,train_activities,train_features)
      
      ##discard unrequired variables
      rm("train_activities"); rm("train_subjects"); rm("train_features")
      
      ##Combine test and train datasets
      combined_set<- bind_rows(test_all,train_all)
      
      ##discard unrequired variables
      rm("test_all"); rm("train_all")
      
      
      ##-------Part 2----------------------------------------------------------
      ## Extracts only the measurements on the mean and 
      ## standard deviation for each measurement.
      ##-----------------------------------------------------------------------
      
      ##reference features.txt to find which variables contain
      ##mean or standard deviation (std)
      features_list <- read.table("features.txt")
      features_of_interest <- grep("mean|std",features_list$V2)
      
      ##increment by two to compensate for the added subject and label columns
      features_of_interest2 <- features_of_interest+2
      
      ##use the select {dplyr} function to exctract only the variables needed
      combined_set <- select(combined_set,subject,activity,features_of_interest2)
      dim(combined_set)
      
      ##-------Part 3----------------------------------------------------------
      ## Uses descriptive activity names to name the activities in the data set 
      ##-----------------------------------------------------------------------
      
      ##read in activity labels
      activity_labels <- read.table("activity_labels.txt")

      ##coerce activity variable into a factor variable
      combined_set$activity <- as.factor(combined_set$activity)
      
      ##rename the levels with descriptive activity names
      levels(combined_set$activity) <- activity_labels$V2
      
      ##combined_set
      combined_set
      
      ##-------Part 4----------------------------------------------------------
      ## Appropriately labels the data set with descriptive variable names.
      ##-----------------------------------------------------------------------
      
      ##use the previously generated features list and features of interest
      ##to generate a list of new column names, coercing to character vector
      descriptive_variable_names <- features_list[features_of_interest,]
      descriptive_variable_names <- as.character(descriptive_variable_names$V2)
      
      ##rename variables
      colnames(combined_set)<- c("subject","activity",descriptive_variable_names)
      
      ##-------Part 5----------------------------------------------------------
      ## From the data set in step 4, creates a second, independent tidy data 
      ## set with the average of each variable for each activity and each subject.
      ##-----------------------------------------------------------------------

      summary <- 
            combined_set %>%
            group_by(subject,activity)
            
      summary <- summarise_each(summary,funs(mean))
      
      write.table(summary,file="analysis.txt",row.name=FALSE)
      print(summary)
      
}