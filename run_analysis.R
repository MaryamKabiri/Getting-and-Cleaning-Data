setwd("C:/Users/Maryam/Desktop/Datascientists/Getting and cleaning data/Week 4")

#loading required packages
packages<-c("data.table", "dplyr", "reshape2")
sapply(packages, require, character.only=TRUE)

if(!file.exists("./data2")){dir.create("./data2")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data2/dataset.zip")

 unzip("./data2/dataset.zip")

############## 1 ##############
## test data
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt")

## train test
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("UCI HAR Dataset/train/Y_train.txt")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
                   
## features and activity data
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

# merging train and test data
X<-rbind(xtest, xtrain)
Y<-rbind(ytest, ytrain)
subject<-rbind(subjecttest, subjecttrain)

############## 2 ##############
extract<-grep("mean\\(\\)|std\\(\\)", features[,2])
length(extract)
 
############3 3 ############
Y[,1]<-activity[Y[,1], 2]
head(Y)

############# 4 ##########
names(Y)<-"activity"
names(subject)<-"subjectID"
featurenames<-features[extract, 2]
names(X)<-featurenames
data<-cbind(subject, Y, X)
dim(data)

########## 5 ############
data<-data.table(data)
tidydata<-data[, lapply(.SD, mean), c("subjectID", "activity")]
dim(tidydata)
write.table(tidydata, file="TidyData.txt", row.names=FALSE)