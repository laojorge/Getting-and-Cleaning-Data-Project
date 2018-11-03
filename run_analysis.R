library(plyr)

## 1.Merges the training and the test sets

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")  ## dim 7352  561
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")  ## dim 7352  1
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")  ## dim 7352     1

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")     ## dim 2947  561
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")     ## dim 2947  1
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") ## dim 2947     1

# merge x_train + x_test
x_train_test <- rbind(x_train, x_test)                      ## dim 10299   561

# merge y_train + y_test
y_train_test <- rbind(y_train, y_test)                      ## dim 10299   1

# merge subject_train + subject_test
subject_train_test <- rbind(subject_train, subject_test)    ## dim 10299     1



## 2.Extracts only the measurements on the mean and standard deviation for each measurement. (features.txt)
features <- read.table("UCI HAR Dataset/features.txt")

## column 2 of features - variable names
vector_features <- features[,2]

## features with "-" follow "mean" or "std" follow "(" follow ")"
features_mean_std <- grep("-(mean|std)\\(\\)", vector_features)

## subset with only the measurements on the mean and standard deviation
subset_x_train_test <- x_train_test[, features_mean_std]

## columns names
names(subset_x_train_test) <- features[features_mean_std, 2]


## 3.Uses descriptive activity names to name the activities in the data set (activity_labels.txt)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

act_labels_y_train_test <- activity_labels[y_train_test[, 1],]

## activities names
y_train_test[, 1] <- act_labels_y_train_test[, 2]

## appropriate name column
names(y_train_test) <- "activity"

## 4.Appropriately labels the data set with descriptive variable names.
names(subject_train_test) <- "subject"

dataset <- cbind(subset_x_train_test, y_train_test, subject_train_test)

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data <- ddply(dataset, .(subject, activity), function(x) colMeans(x[, 1:66]))
    
write.table(tidy_data, "tidy.txt", row.name=FALSE)

