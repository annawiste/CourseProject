##CourseProject
require(data.table)
require(dplyr)  
require(plyr) 
require(tidyr)
##Read in data
temp<-tempfile()
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
temp1<-unzip(temp)

#Get list of files downloaded, identify pathname for README
temp1
#Open README.txt
readme <- readLines("./UCI HAR Dataset/README.txt")
#Identify pathname for training dataset and read in
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
#Identify pathname for testing dataset and read in
test<-read.table("./UCI HAR Dataset/test/X_test.txt")
#training and testing datasets, each 561 variables, will use rbind
#first, check how many rows the merged file should have
dim(train)
dim(test)

#Read in ancillary files with subject and activity information
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
labels_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
labels_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

#rename variables in subjects and activity files to avoid duplicates
colnames(labels_train)[colnames(labels_train)=="V1"] <- "Activity"
colnames(labels_test)[colnames(labels_test)=="V1"] <- "Activity"
colnames(subject_train)[colnames(subject_train)=="V1"] <- "Subject"
colnames(subject_test)[colnames(subject_test)=="V1"] <- "Subject"

#combine three data frames into 1 data frame each for train and test
train_all<-cbind(subject_train, labels_train, train)
test_all<-cbind(subject_test, labels_test, test)

#merge train and test
full<-rbind(train_all, test_all)
#merged dataset should have same number of columns as both train and test
#and rows should be sum of train and test rows.
##Completes Part 1##


#Aim to create data frame with variable number and associated name of feature in two columns.
#This is then used to match extract the desired data and rename the variables.

#open file with list of features (find filename in README.txt)
features <- readLines("./UCI HAR Dataset/features.txt")
#create vector with all features that are mean or standard 
#deviation of the measurements. We take measures that include 'mean()' 
#and exclude the other features which have mean in their name, but are not an activity mean
mean<-grep(("mean()"), features, value=TRUE,fixed=TRUE)
std<-grep("std", features, value=TRUE)
feat<-c(mean, std)

#Used string split to split by space, creating a list of vectors, each with var number and 
#name. 
feats <- strsplit(feat, " ")

#step 1 in making data frame
featsDF<-do.call("rbind", feats)
#completes data frame with col 1=selected variable number, and col 2= variable names
featsDFa<-as.data.frame(featsDF)

#change variable names to avoid confusion
setnames(featsDFa, old=c("V1", "V2"), new=c("varnumbers", "varnames"))
featsDFa$varnumbers<-as.numeric(as.character(featsDFa$varnumbers))
#add 'Subject' and 'Activity' to top of data frame. Will need them when we use this data
#frame to extract data from the larger one.
S_A<-data.frame(x=c("Subject", "Activity"), y=c("Subject", "Activity"))
setnames(S_A, old=c("x", "y"), new=c("varnumbers", "varnames"))
#Add V to front of all variable numbers
featsDFa$varnumbers<- paste("V", featsDFa$varnumbers, sep="")
featsdf<-rbind(S_A, featsDFa)
#Create vector with desired variable numbers from the data frame of desired features
varnumbers<-as.character(featsdf[,1])
#extract columns from full dataset containing variables named "V#" according to varnumbers
means_std<-full[,varnumbers]
##Completes Part 2##

#Add appropriate descriptive variable names by renaming columns using featsdf$varnames. 
#The first column of the data frame 'featsdf' contains the numbers for chosen 
#variables, and second column matches descriptive variable names to appropriate numbers.
##This step completes part 4 of the assignment##
colnames(means_std)<-featsdf[,2]

##Add activity name in place of # in 'Activity'. Completes Part 3 of assignment##
means_std$Activity[means_std$Activity==1] <-"WALKING"
means_std$Activity[means_std$Activity==2] <-"WALKING_UPSTAIRS"
means_std$Activity[means_std$Activity==3] <-"WALKING_DOWNSTAIRS"
means_std$Activity[means_std$Activity==4] <-"SITTING"
means_std$Activity[means_std$Activity==5] <-"STANDING"
means_std$Activity[means_std$Activity==6] <-"LAYING"

#Group data by Subject and Activity to summarize and get the mean value for each combination.
means_std1<-group_by(means_std, Subject, Activity)
FINAL<-summarise_each(means_std1, funs(mean))

write.table(FINAL, file="final.txt", row.names=FALSE)
