# create table of the 561 variables collected by the smartphones
smart_vars <- read.table("features.txt", sep = " ", stringsAsFactors = FALSE)
# identify the correct variable names
selected_vars <- grep("mean\\(\\)|std()", smart_vars[,2], value = TRUE)
#identifies the corresponding index to the names
selected_vars_indices <- grep("mean\\(\\)|std()", smart_vars[,2])

# create training tables from raw info
training <- read.table("X_train.txt", stringsAsFactors = FALSE, header = FALSE, sep="")
training_subject <- read.table("subject_train.txt", stringsAsFactors = FALSE, header = FALSE, sep="")
training_activity <- read.table("y_train.txt", stringsAsFactors = FALSE, header = FALSE, sep="")

#create data frame based on training, which extracts only desired variables
#and combines these extracted variables with subject indicator and activity indicator

training_full <- data.frame(training_subject, training_activity,training[,selected_vars_indices])
names(training_full) <- c("subject","activity",selected_vars)
training_full <- mutate(training_full, activity = as.factor(activity))
levels(training_full$activity) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING", "LAYING")


# create test tables from raw info
test <- read.table("X_test.txt", stringsAsFactors = FALSE, header = FALSE, sep="")
test_subject <- read.table("subject_test.txt", stringsAsFactors = FALSE, header = FALSE, sep="")
test_activity <- read.table("y_test.txt", stringsAsFactors = FALSE, header = FALSE, sep="")

#create data frame based on test, which extracts only desired variables
#and combines these extracted variables with subject indicator and activity indicator

test_full <- data.frame(test_subject, test_activity,test[,selected_vars_indices])
names(test_full) <- c("subject","activity",selected_vars)
test_full <- mutate(test_full, activity = as.factor(activity))
levels(test_full$activity) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING", "LAYING")

# combine the training and test data frames into one big data frame
combined_df <- rbind(training_full, test_full)

# now we need to create the data set with avg of EACH variable for each ACTIVITY and SUBJECT. This is simple with the "summarize_all" function I discovered randomly. 

tidy_df <- group_by(combined_df, subject, activity) %>%
summarize_all(mean)
    
write.table(tidy_df, "Nathaniel.txt", row.names = FALSE)
