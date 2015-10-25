## Note : We assume that the Samsung data set has been unzip in the working directory

library(dplyr)

## Step 0 - Identify usefull columns (mean & std deviation) for the assignment 
    featuresFile <- read.table("./UCI HAR Dataset/features.txt")
    columnFilter <- featuresFile[grep("mean|std", featuresFile[,2], ignore.case = TRUE),]

## Step 1 - Create tidy data with X and Y files from test directory
    x_testFile <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_testFile <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subject_testFile <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    ## Apply column filter and labels columns
        x_testFileFiltered <- data.frame(matrix(ncol = 0, nrow = nrow(x_testFile)))
        for(i in columnFilter[,1]){
            x_testFileFiltered <- cbind(x_testFileFiltered, x_testFile[,i])
        }
        colnames(x_testFileFiltered) <- columnFilter[,2]
    ## Merge X and Y test files 
        testData <- cbind(y_testFile, subject_testFile , x_testFileFiltered)
    
## Step 2 - Create tidy data with X and Y files from train directory
    x_trainFile <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_trainFile <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject_trainFile <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    ## Apply column filter and labels columns
        x_trainFileFiltered <- data.frame(matrix(ncol = 0, nrow = nrow(x_trainFile)))
        for(i in columnFilter[,1]){
            x_trainFileFiltered <- cbind(x_trainFileFiltered, x_trainFile[,i])
        }
        colnames(x_trainFileFiltered) <- columnFilter[,2]
    ## Merge X and Y train files 
        trainData <- cbind(y_trainFile, subject_trainFile, x_trainFileFiltered)   
    
## Step 3 - Merge previous data into a unique data set
    UniqueDataSet <- rbind(testData, trainData)

## Step 4 - Add descriptive labels for activity and subject
    Activity <- gsub("1",UniqueDataSet[,1], replacement = "WALKING")
    Activity <- gsub("2",Activity, replacement = "WALKING_UPSTAIRS")
    Activity <- gsub("3",Activity, replacement = "WALKING_DOWNSTAIRS")
    Activity <- gsub("4",Activity, replacement = "SITTING")
    Activity <- gsub("5",Activity, replacement = "STANDING")
    Activity <- gsub("6",Activity, replacement = "LAYING")
    names(UniqueDataSet)[2] <- "Subject_ID"
    
    UniqueDataSet <- cbind(Activity, UniqueDataSet[,2:ncol(UniqueDataSet)])
    
## Step 5 : Create a data set with the average of each variable for each activity and each subject
    tblDataSet <- tbl_df(UniqueDataSet)
    agg_results <- tblDataSet %>% group_by(Subject_ID, Activity) %>% summarise_each(funs(mean))
    write.table(agg_results, file = "./UCI HAR Dataset/Tidy_data_set.txt", row.names = FALSE)
    