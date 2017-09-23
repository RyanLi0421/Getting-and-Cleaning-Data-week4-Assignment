wd <- "/Users/liziran/Documents/终生学习/Coursera/Data Science Specialization Course/3.Getting and Cleaning Data/week4/Assignments"
test_dir <- paste(wd, "/UCI_HAR_Dataset/test", sep = "")
train_dir <- paste(wd, "/UCI_HAR_Dataset/train", sep = "")
UCI_HAR_Dataset <- paste(wd, "/UCI_HAR_Dataset", sep = "")

# read test and train files into variables
setwd(test_dir)
features_test <- read.table("x_test.txt")
labels_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

setwd(train_dir)
features_train <- read.table("x_train.txt")
labels_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

# 1.Merges the training and the test sets to create one data set.
# create a new dataset to merge train and test data together
mydata_test <- cbind(subject_test, labels_test, features_test)
mydata_train <- cbind(subject_train, labels_train, features_train)
mydata <- rbind(mydata_test, mydata_train)


# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# read feature file 
setwd(UCI_HAR_Dataset)
features <- read.table("features.txt")
features <- as.character(features[,2])

# grep mean and sd in feature, return index of mean and sd
mean_sd <- grep("(mean)|(std)", features)
mean_sd_index <- mean_sd + 2

# subset mydata using mean and sd index
mydata_MeanSD <- mydata[,c(1,2,mean_sd_index)]


# 3.Uses descriptive activity names to name the activities in the data set
# gsub int value to descriptive names
y1 <- gsub(1, "WALKING", mydata_MeanSD[,2])
y2 <- gsub(2, "WALKING_UPSTAIRS", y1)
y3 <- gsub(3, "WALKING_DOWNSTAIRS", y2)
y4 <- gsub(4, "SITTING", y3)
y5 <- gsub(5, "STANDING", y4)
y6 <- gsub(6, "LAYING", y5)

activity <- as.factor(y6)

mydata_MeanSD[,2] <- activity

# 4.Appropriately labels the data set with descriptive variable names.
# set colnames for mydata
features <- gsub("-", "_", features)
features <- gsub(",", "_", features)
features <- gsub("\\(\\)", "", features)
# subset names including mean and sd
features_name <- features[mean_sd]

colnames(mydata_MeanSD) <- c("Subjects","Activity_Labels", features_name)


# 5.creates a second, independent tidy data set
setwd(wd)
write.table(mydata_MeanSD, file = "tidy.txt", row.names = F)