####################################################
# Run analysis on accelerometer and gyroscope data #
####################################################

#make the "UCI HAR Dataset" folder your current directory
message("Current path: ", getwd())

#load the activity labels into a table
message("Loading activity labels and features...")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("num", "activity"))
features <- read.table("UCI HAR Dataset/features.txt")

#load the test data with subjects and labels
message("Loading test data...")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testData <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[[2]])
testData$subject <- testSubjects[[1]]
testData$label <- testLabels[[1]]

#load the training data with subjects and labels
message("Loading training data...")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[[2]])
trainData$subject <- trainSubjects[[1]]
trainData$label <- trainLabels[[1]]

#combine test and training data sets
message("Merging data...")
allData <- rbind(testData, trainData)
#select subset of columns (mean, std, subject and label)
allData <- select(allData, contains(".mean.."), contains(".std.."), subject, label)
#simplify column names by removing extra dots
names(allData) <- gsub("..", "", names(allData), fixed = TRUE)
#substitute the activity numbers with descriptive names
allData <- merge(allData, activityLabels, by.x = "label", by.y = "num", all = TRUE)
#drop extra column
allData <- select(allData, -label)
#order data based on subject and activity
allData <- allData[order(allData$subject, allData$activity),]

#create tidy data set
message("Summarizing and writing to file output.txt...")
#summarize data based on subject and activity columns, and compute mean on the rest
tidyData <- summarise_each(group_by(allData, activity, subject), funs(mean))
#write tidyData to file
write.table(tidyData, "UCI HAR Dataset/output.txt", row.name=FALSE)