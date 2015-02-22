
## mount test  ###############################################################
 features <- read.table(file ="./UCI HAR Dataset/features.txt",header = FALSE)
 test <- read.table(file ="./UCI HAR Dataset/test/X_test.txt", header = FALSE,  colClasses = "numeric")
 colnames (test) <- features$V2

## read acitivies
 test_act <- read.table(file ="./UCI HAR Dataset/test/y_test.txt", header = FALSE)
 act <- read.table(file ="./UCI HAR Dataset/activity_labels.txt",header = FALSE)
 colnames(test_act) <- "Activities"
 
## read Subjects
 
 test_sub <- read.table(file ="./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
 colnames(test_sub) <- "Subjects"
 
 # add columns Activities and Subject
 
 test <- cbind(test,test_act)
 test <- cbind(test,test_sub)
 
 ## mount train #############################################################

 train <- read.table(file ="./UCI HAR Dataset/train/X_train.txt", header = FALSE,  colClasses = "numeric")
colnames (train) <- features$V2

 ## read acitivies
 train_act <- read.table(file ="./UCI HAR Dataset/train/y_train.txt", header = FALSE)
colnames(train_act) <- "Activities"

 ## read Subjects
 
 train_sub <- read.table(file ="./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
colnames(train_sub) <- "Subjects"

 # add columns Activities and Subject to train
 
 train <- cbind(train,train_act)
 train <- cbind(train,train_sub)

## mount final data.frame

final <- rbind(test, train)
 
 ## separate columns with "mean", "std"
mean <- grep("mean()", features$V2)
std <- grep("std()", features$V2)
filter <- c(std,mean, c(562,563))
final_filter <- final[,filter]

tinyData <- aggregate ( x = final_filter, by = list(final_filter$Subjects,final_filter$Activities), mean)

## adjust Activities to text

for( i in 1:length(tinyData$Activities)) {
                                        
         x <- act$V2[[as.numeric(tinyData$Activities[i])]]
         tinyData$Activities[[i]] <- as.vector(x)
 }
 
write.table( tinyData, file ="./UCI HAR Dataset/tinyData.txt" ,row.name=FALSE)





