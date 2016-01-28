library(data.table)
library(dplyr)


#### load train data
trainDataFile <- "./UCI HAR Dataset/train/X_train.txt"
traindata <- fread(trainDataFile, sep = " ")

#### load test data
testDataFile <- "./UCI HAR Dataset/test/X_test.txt"
testdata <- fread(testDataFile, sep = " ")

#### combine data
combineddata <- rbind(traindata, testdata)

#### load feature names
featuresFilePath <- "./UCI HAR Dataset/features.txt"
features <- fread(featuresFilePath, sep = " ", col.names = c("index", "featurename"))

#### extarct measurements on mean and std for each measurement
colnames(combineddata) <- features$featurename
selectattributes <- select(combineddata, matches("mean\\(\\)|std\\(\\)"))

#### load train labels
trainLabelFile <- "./UCI HAR Dataset/train/y_train.txt"
trainlabels <- read.csv(file = trainLabelFile, header = FALSE, col.names = c("label"))

#### load test labels
testLabelFile <- "./UCI HAR Dataset/test/y_test.txt"
testlabels <- read.csv(file = testLabelFile, header = FALSE, col.names = c("label"))

combinedlabels <- rbind(trainlabels, testlabels)

#### load activity names
labelsFilePath <- "./UCI HAR Dataset/activity_labels.txt"
labels <- fread(labelsFilePath, sep = " ", col.names = c("index", "activityname"))

desclabels <- merge(combinedlabels, labels, by.x = "label", by.y = "index")

selectattributes <- cbind(selectattributes, desclabels)

#### load train subject data
trainSubjectPath  <- "./UCI HAR Dataset/train/subject_train.txt"
trainsubjects <- fread(trainSubjectPath, sep = " ", col.names = c("subject"))

#### load test subject data
testSubjectPath  <- "./UCI HAR Dataset/test/subject_test.txt"
testsubjects <- fread(testSubjectPath, sep = " ", col.names = c("subject"))

combinedsubjects <- rbind(trainsubjects, testsubjects) 
meanattributes <- selectattributes %>% cbind(combinedsubjects) %>% 
                  select(-label) %>% group_by(subject, activityname) %>% 
                  summarize_each(c("mean"))

write.table(meanattributes, file = "har_dataset.txt", row.names = FALSE, quote = FALSE)

## select_features <- names(meanattributes)
## selectfeatures_df <- data.frame(index = 1:length(select_features), features = select_features)
## write.table(selectfeatures_df, file = "features.txt", row.names = FALSE)
