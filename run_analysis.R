# Download and unzip the dataset
filename <- "dataset.zip"
if (!file.exists(filename)) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = filename)
}
if (!file.exists("UCI HAR Dataset")) {
    unzip(filename)
}


library(dplyr)


# Read features and activity labels
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$V2)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$V2)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Merge training and test data
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
merged_data <- cbind(Subject, Y, X)

tidy_data <- merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

tidy_data$code <- activity_labels[tidy_data$code, 2]
names(tidy_data)[2] <- "activity"

names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-std\\(\\)", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq\\(\\)", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gravity", names(tidy_data))

final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))

# Save output
write.table(final_data, "tidy_dataset.txt", row.name = FALSE)
