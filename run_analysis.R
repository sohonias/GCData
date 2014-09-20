Enter file contents herelibrary(dplyr)
library(tidyr)

##Read training and test data

data_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
#print(dim(data_train))

data_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
#print(dim(data_test))

sub_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
#print(dim(sub_train))

sub_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
#print(dim(sub_test))


y_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
#print(dim(y_train))

y_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
#print(dim(y_test))


##merging columns (X and Y)

completeTraining <- cbind(sub_train, y_train, data_train)
completeTest <- cbind(sub_test, y_test, data_test)

##merging rows (training and test)
completeData <- rbind(completeTraining, completeTest)


# Read features for column headers

features <- read.table("./UCI_HAR_Dataset/features.txt")
#print(dim(features))

featureNames <- as.character(features[,2])
newNames <- c("subject", "activity", featureNames)
colnames(completeData) <- newNames

# only select columns pertaining mean and std
meanCols <- select(completeData, contains("mean\\(", ignore.case=FALSE))
stdCols <- select(completeData, contains("std\\(", ignore.case=FALSE))

msCols <- cbind(meanCols, stdCols)
samsCols <- cbind(completeData[,"subject"], completeData[,"activity"], msCols)
colnames(samsCols)[1] <- "subject"
colnames(samsCols)[2] <- "activity"

#Read Activity table
activities <- read.table("./UCI_HAR_Dataset/activity_labels.txt")
#print(dim(activities))

#replace activity numbers by activity names
newActivities <- character(nrow(samsCols))

for (i in 1:nrow(samsCols))
{
  old <- NULL
  actName <- NULL
  
  old <- as.character(samsCols[i,2])
  
  if (old == "1") actName <- as.character(activities[1,2])
  else if (old == "2") actName <- as.character(activities[2,2])
  else if (old == "3") actName <- as.character(activities[3,2])
  else if (old == "4") actName <- as.character(activities[4,2])
  else if (old == "5") actName <- as.character(activities[5,2])
  else if (old == "6") actName <- as.character(activities[6,2])
  else actName <- old
  
  newActivities[i] <- actName
#  print(newActivities[i])
}

samsCols <- mutate(samsCols, activity=newActivities)



##Split by subject and activity
listBySA <- split(samsCols, list(samsCols$subject, samsCols$activity))

myColMeans <- function (thisSA) {
  myMeans <- colMeans(select(thisSA, 3:ncol(thisSA)))
  myMeans
}

#apply colMeans() on each variable
meansComplete <- lapply(listBySA,  FUN=myColMeans)
meansTab <- t(as.data.frame(meansComplete))

write.table(meansTab, "./averages.txt", row.name=FALSE, sep="\t") 



