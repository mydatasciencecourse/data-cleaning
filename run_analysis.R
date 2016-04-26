library(plyr)

features=readLines("UCI HAR Dataset/features.txt")
activities=read.delim("UCI HAR Dataset/activity_labels.txt", sep="", header=F)

datasetFrame=function(setname){
  # Read the data.
  data=read.delim(paste("UCI HAR Dataset/", setname, "/X_", setname, ".txt", sep=""), sep="", header=F)
  subjects=read.delim(paste("UCI HAR Dataset/", setname, "/subject_", setname, ".txt", sep=""), sep="", header=F)
  activity=read.delim(paste("UCI HAR Dataset/", setname, "/y_", setname, ".txt", sep=""), sep="", header=F)
  
  # Add activity and subject column.
  result=cbind(data, subjects, activity)
  colnames(result)=append(features, c("subject", "activity"))
  # Translate activity codes.
  result$activity=activities[result$activity, 2]
  
  result
}

# Read in the data for test and train set.
train=datasetFrame("train")
test=datasetFrame("test")
# Train and test data are separated by persons. Thus, we are looking for the
# union of the two data sets (not a join)
completeData=rbind(train, test)

# According to file "features_info.txt", "std()" and "mean()" indicates mean and
# standard deviation values. There is also something like meanFreq() => Check 
# for brackets after "mean"/"std".
filtered=completeData[, grepl("std\\(\\)|mean\\(\\)|subject|activity", names(completeData))]

# Take mean values and clean up variable names.
# See also: http://www.magesblog.com/2012/01/say-it-in-r-with-by-apply-and-friends.html
tidy=ddply(filtered, .(subject, activity), function(x) colMeans(subset(x, select= c(-subject, -activity))))
names(tidy)=gsub("^\\d+ ([a-zA-Z])", "\\1", names(tidy))
names(tidy)[3:length(names(tidy))]=gsub("^", "meanOf", names(tidy)[3:length(names(tidy))])

write.table(tidy, file="tidy.txt", row.names = F)