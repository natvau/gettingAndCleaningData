# 1. Merges the training and the test sets to create one data set.
setwd(paste(getwd(), "/UCI HAR Dataset/", sep=""))
train <- read.table("train/X_train.txt", header=FALSE, sep = "")
train <- cbind(train, read.table("train/subject_train.txt"), read.table("train/y_train.txt"))
test <- read.table("test/X_test.txt", header=FALSE, sep = "")
test <- cbind(test, read.table("test/subject_test.txt"), read.table("test/y_test.txt"))
data <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)
features <- make.names(features[,"V2"])
mean_std <- data[,grep(pattern="std|mean", x=features, ignore.case=TRUE)]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)
activity_labels <- apply(activity_labels, 1, function(x) unlist(strsplit(x, split=" ")))
data[,563] <- factor(as.factor(data[,563]), labels=activity_labels[2,])

# 4. Appropriately labels the data set with descriptive activity names. 
features <- read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)
features <- make.names(features[,"V2"])
features[562] = "subject"
features[563] = "activity"
colnames(data) <- features

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
labels <- colnames(data)[-c(562,563)]
data2 <- lapply(X=labels, FUN=function(x) tapply(data[[x]], list(data$activity, data$subject), mean))
names(data2) <- labels
capture.output(data2, file = "tidy_data.txt")