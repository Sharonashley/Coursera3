#packages

install.packages("dplyr")
library(dplyr)

#download data
rawdataDir <- "./rawData2"
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "rawData.zip"
datafiledir <- paste(rawdataDir, "/", "rawData.zip", sep = "")
dataDir <- "./data4"

if (!file.exists(rawdataDir)) {
    dir.create(rawdataDir)
    download.file(url = dataUrl, destfile = "datass.zip", method = "curl")
}
if (!file.exists(dataDir)) {
    dir.create(dataDir)
    unzip(zipfile = "datass.zip", exdir = dataDir)
}
#read tables
Xtest<- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/test/X_test.txt"))
Ytest <- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/test/y_test.txt"))
Xtrain <- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/train/X_train.txt"))
Ytrain <- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/train/y_train.txt"))

subjecttest <- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/test/subject_test.txt"))
subjecttrain <- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/train/subject_train.txt"))

#add subjects to the Y dataset

Ytrain2 <- cbind(Ytrain, subjecttrain)
Ytest2 <- cbind(Ytest, subjecttest)

#combine X's, Y's into one dataset

totalX <- rbind(Xtrain, Xtest)
totalY <- rbind(Ytrain2, Ytest2)

#combine into one dataset

all_data <- cbind(totalX, totalY)


#the second last column here is the labels, Y, and the last columnn is the subject

#extract only the measurements on the mean and standard deviation of each measurement

#read in the features.txt file

features <- read.table(paste(sep = "", dataDir, "/UCI HAR DATASET/features.txt"))

#select only the rows of this dataset where the words "mean" or "std" are present

features <- features[grepl(".*mean.*|.*std.*", features$V2), ]

#now select only these columns from all_data, make sure to include Y

all_data <- all_data[, c(features$V1, 562, 563)]

#rename the activities with the proper names

all_data <- all_data %>% mutate(V1.1 = replace(V1.1, V1.1 ==1, "Walking")) %>% mutate(V1.1 = replace(V1.1, V1.1 ==2, "Walking_Upstairs")) %>% mutate(V1.1 = replace(V1.1, V1.1 ==3, "Walking_Downstairs")) %>% mutate(V1.1 = replace(V1.1, V1.1 ==4, "Sitting")) %>% mutate(V1.1 = replace(V1.1, V1.1 ==5, "Standing")) %>% mutate(V1.1 = replace(V1.1, V1.1 ==6, "Laying"))
                                
#rename the column headings

colnames(all_data) <- c(features$V2, "Activity", "Subject")

#create a second, independent tidy data set with the average of each variable for each activity and each subject

summarized_data <- all_data %>% group_by(Activity, Subject) %>% summarize_all(mean)

#write original, clean dataset

write.table(all_data, "./all_data.txt", row.names = FALSE, quote = FALSE)

#write tidy dataset

write.table(summarized_data, "./summarized_data.txt", row.names = FALSE, quote = FALSE)

colnames(all_data)