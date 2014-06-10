# 1. Merges the training and the test sets to create one data set.
setwd('~/Desktop/coursera/data specialization/3.GettingAndCleaningData/project/UCI HAR Dataset/')
dir <- list.files()[file.info(list.files())[,'isdir']]
pattern <- paste('_', dir, '$', collapse='|', sep='')
files <- list.files(recursive=TRUE)
filesTest <- files[grep('^test', files)]
filesTrain <- files[grep('^train', files)]
df <- NULL
for(f in 1:length(filesTest)) {
  colName <- strsplit(filesTest[f], split = '[\\.|/]')
  colName <- colName[[1]][length(colName[[1]])-1]
  colName <- strsplit(colName, split = pattern)
  colName <- unlist(colName)
  testData <- readLines(filesTest[f])
  trainData <- readLines(filesTrain[f])
  if(is.null(df)) {
    df <- data.frame(c(testData, trainData))
    colnames(df) <- colName
  } else {
    df[colName] <- c(testData,trainData)
  }
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mymean <- function(x) {
  mean(na.omit(as.numeric(unlist(strsplit(as.character(x), split=' ')))))
}
mean <- apply(df, MARGIN=c(1,2), FUN=mymean)

mysd <- function(x) {
  x <- na.omit(as.numeric(unlist(strsplit(as.character(x), split=' '))))
  if(length(x) > 1)
    sd(x)
  else
    0
}
sd <- apply(df, MARGIN=c(1,2), FUN=mysd)

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.csv('activity_labels.txt', header=FALSE, stringsAsFactors=FALSE)
activity_labels <- apply(activity_labels, 1, function(x) unlist(strsplit(x, split=' ')))
#map <- factor(activity_labels[2,]) #df[,'y'] <- as.factor(map[as.integer(df[,'y'])])
df[,'y'] <- factor(as.factor(df[,'y']), labels=activity_labels[2,])

# 4. Appropriately labels the data set with descriptive activity names. 
colnames(df)[which(colnames(df)=='y')] <- 'activity'

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 