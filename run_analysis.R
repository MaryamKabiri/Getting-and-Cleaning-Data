setwd("C:/Users/Maryam/Desktop/Datascientists/Getting and cleaning data/Week 4")

# Loading zip file to computre
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data2/dataset.zip")

#Unzip the file 
 unzip("./data2/dataset.zip")

#Reading and combining test data sets
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt")

#Reading and combining train data sets
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("UCI HAR Dataset/train/Y_train.txt")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
                   
#Reading features and activity data sets
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

# Merging train and test data sets
X<-rbind(xtest, xtrain)
Y<-rbind(ytest, ytrain)
subject<-rbind(subjecttest, subjecttrain)

#Extract the mean and standard deviation for each observation 
extract<-grep("mean\\(\\)|std\\(\\)", features[,2])
length(extract)
 
#Name the activities data set
Y[,1]<-activity[Y[,1], 2]
head(Y)

#Lable the data sets
names(Y)<-"activity"
names(subject)<-"subjectID"
featurenames<-features[extract, 2]
names(X)<-featurenames
data<-cbind(subject, Y, X)
dim(data)

#Create new tidy data set with average of eac variable for each activity and subject
data<-data.table(data)
tidydata<-data[, lapply(.SD, mean), c("subjectID", "activity")]
dim(tidydata)
write.table(tidydata, file="TidyData.txt", row.names=FALSE)
