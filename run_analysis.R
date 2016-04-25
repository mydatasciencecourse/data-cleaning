features=readLines("UCI HAR Dataset/features.txt")
activities=read.delim("UCI HAR Dataset/activity_labels.txt", sep="", header=F)

datasetFrame=function(setname){
  data=read.delim(paste("UCI HAR Dataset/", setname, "/X_", setname, ".txt", sep=""), sep="", header=F)
  subjects=read.delim(paste("UCI HAR Dataset/", setname, "/subject_", setname, ".txt", sep=""), sep="", header=F)
  activity=read.delim(paste("UCI HAR Dataset/", setname, "/y_", setname, ".txt", sep=""), sep="", header=F)
  
  result=cbind(data, subjects, activity)
  colnames(result)=append(features, c("subject", "activity"))
  result$activity=activities[result$activity, 2]
  
  result
}

train=datasetFrame("train")
test=datasetFrame("test")
# Train and test data are separated by persons. Thus, we are looking for the
# union of the two data sets (not a join)
completeData=rbind(train, test)

# According to file "features_info.txt", "std()" and "mean()" indicates mean and
# standard deviation values. There is also something like meanFreq() => Check 
# for brackets after "mean"/"std".
filtered=completeData[, grepl("std\\(\\)|mean\\(\\)|subject|activity", names(completeData))]

factors=list(filtered$subject, filtered$activity)
tidy=split(filtered, factors)
tidy=lapply(tidy, function(e){if(class(e)=="numeric"){colMeans(e)}else{e}})
tidy=unsplit(tidy, factors)

write.table(tidy, file="tidy.txt", row.names = F)