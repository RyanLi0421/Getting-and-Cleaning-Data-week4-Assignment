wd <- getwd()
test_dir <- paste(wd, "/UCI_HAR_Dataset/test", sep = "")
train_dir <- paste(wd, "/UCI_HAR_Dataset/train", sep = "")
UCI_HAR_Dataset <- paste(wd, "/UCI_HAR_Dataset", sep = "")

# read test and train files into variables
setwd(test_dir)
x_test <- read.table("x_test.txt", sep = "\t")
y_test <- read.table("y_test.txt", sep = "\t")
subject_test <- read.table("subject_test.txt", sep = "\t")

setwd(train_dir)
x_train <- read.table("x_train.txt", sep = "\t")
y_train <- read.table("y_train.txt", sep = "\t")
subject_train <- read.table("subject_train.txt", sep = "\t")

setwd(wd)

# 1.Merges the training and the test sets to create one data set.
# create a new dataset to merge train and test data together
mydata_test <- cbind(subject_test, x_test, y_test)
mydata_train <- cbind(subject_train, x_train, y_train)
mydata <- rbind(mydata_test, mydata_train)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# read feature file 
setwd(UCI_HAR_Dataset)
features <- read.table("features.txt", sep = "\t")
setwd(wd)

# grep mean and sd in feature
mean_sd_measures <- grep("(mean)|(std)", features[,1], value = T)

# 3.Uses descriptive activity names to name the activities in the data set
# gsub int value to descriptive names
y1 <- gsub(1, "WALKING", mydata[,3])
y2 <- gsub(2, "WALKING_UPSTAIRS", y1)
y3 <- gsub(3, "WALKING_DOWNSTAIRS", y2)
y4 <- gsub(4, "SITTING", y3)
y5 <- gsub(5, "STANDING", y4)
y6 <- gsub(6, "LAYING", y5)

mydata[,3] <- y6

# 4.Appropriately labels the data set with descriptive variable names.
names(mydata) <- c("subjects","set","label")

# 5.creates a second, independent tidy data set 
setwd(wd)
write.table(mydata, file = "tidy.txt", row.names = F)





