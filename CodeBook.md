# Code book for "Getting and Cleaning Data Course Project"

## Data source

The data for this project is taken from an analysis of smartphone data. The data is taken from here: [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The description of the data set can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The data is provided as a zip-file. Please see the above links for describtion of the data.

The values of the original data are unchanged for the analysis. Please refer to the original data documentation for units, scaling and applied transformations of the original data.

## Applied transformations

### Preparation

The zip file is unzipped manually and added to the project folder. The data of the following files were read into R:

- UCI HAR Dataset/features.txt
- UCI HAR Dataset/activity_labels.txt
- UCI HAR Dataset/test/X_test.txt
- UCI HAR Dataset/test/subject_test.txt
- UCI HAR Dataset/test/y_test.txt
- UCI HAR Dataset/train/X_train.txt
- UCI HAR Dataset/train/subject_train.txt
- UCI HAR Dataset/train/y_train.txt

_Please see [R documentation](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/download.file.html) for downloading a file via R and [R documentation](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/unzip.html) for unzipping the file via R._

### Assign activity labels and subject

Based on each subject_...txt-file, the subject ids are assigned to each row of the data set.

Based on each activity_labels file, the activity labels are assigned to each row of the data set.

### Merging the data

The original data is separated into test and train set based on individual subjects. Test and train set contain the same variables. There is no subject, which has data in both, train **and** test set. Thus, the data is combined by union (and not a traditional join by some attribute).

### Cleaning up the data

Only the mean and standard deviation columns from the original data together with the subject and activity columns is used. All other columns are discarded.

### Averaging over columns by subject and activity

For each remaining variable, the column mean is calculated for each subject **and** activity independent. There are 30 subjects in total and 6 activities. This leads to 180 numbers for each variable.

### Renaming variables

Trailing numbers are removed from variable names. Each variable is renamed to reflect the fact, that the mean of the original values is taken.

## Data target

Cleaned up data set is written to a file called "tidy.txt". The file contains a header for each variable.