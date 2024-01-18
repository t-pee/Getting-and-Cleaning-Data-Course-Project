### run_analysis.R
### TMP 1/17/24 19:54 
###
### Getting & Cleaning Data course project
### 1. Merges the training and the test sets to create one data set.

### 2. Extracts only the measurements on the mean and 
###    standard deviation for each measurement. 

### 3. Uses descriptive activity names to name the 
###    activities in the data set.

### 4. Appropriately labels the data set with 
###    descriptive variable names. 

### 5. From the data set in step 4, creates a second, 
###    independent tidy data set with the average of 
###    each variable for each activity and each subject.

library(tidyr)
library(dplyr)
library(tibble)

main <- function() {
  ## 0. Read in the raw data
  ## 0a. Set some temp variables to keep things clean
  pathDatTest    <- "./Data/UCI HAR Dataset/test/X_test.txt"
  pathNamesTest  <- "./Data/UCI HAR Dataset/test/y_test.txt"
  pathDatTrain   <- "./Data/UCI HAR Dataset/train/X_train.txt"
  pathNamesTrain <- "./Data/UCI HAR Dataset/train/y_train.txt"
  pathActivities <- "./Data/UCI HAR Dataset/activity_labels.txt"
  pathFeatures   <- "./Data/UCI HAR Dataset/features.txt"
  
  ## 0b. Read in all the raw data
  datTest    <- read.table(pathDatTest)
  datTrain   <- read.table(pathDatTrain)
  actTest    <- read.table(pathNamesTest)
  actTrain   <- read.table(pathNamesTrain)
  namesAct   <- read.table(pathActivities)
  namesFeat  <- read.table(pathFeatures)

  ## 0c. Clean up
  rm(pathDatTest)
  rm(pathNamesTest)
  rm(pathDatTrain)
  rm(pathNamesTrain)
  rm(pathActivities)
  rm(pathFeatures)
  
  
  ## 1 & 4. Combine Test and Train data into single table
  ## 1 & 4a. Add variable names to the main data tables
  names(datTest)  <- namesFeat[,2]
  names(datTrain) <- namesFeat[,2]

  ## 1b. Add in factor for type of data as first column (variable)
  datTypeTest <- rep("Test", length(datTest[,1]))
  datTypeTrain <- rep("Train", length(datTrain[,1]))
  datTest  <- cbind(datTypeTest,  datTest)
  datTrain <- cbind(datTypeTrain, datTrain)
  names(datTest)[1]  <- "DataType"
  names(datTrain)[1] <- "DataType"

  ##  1c. Bind the activities as new first column (variable)
  datTest  <- cbind(actTest,  datTest)
  datTrain <- cbind(actTrain, datTrain)
  names(datTest)[1]  <- "Activity"        ## Rename column
  names(datTrain)[1] <- "Activity"
  
  ## 1d. Merge the two tables into one
  datAll <- rbind(datTest, datTrain)
  
  ## 1e. Remove the original tables to free up some memory
  rm(datTest)
  rm(datTrain)
  rm(actTest)
  rm(actTrain)
  rm(namesFeat)
  rm(datTypeTest)
  rm(datTypeTrain)
  
  
  ## 2. Tidy up: Remove unnecessary variables
  ## 2a. We only need variables for mean & std dev.
  ##     (and Activity and dataType that we added)
  colAct  <- 1                      ## 1st column
  colType <- 2                      ## 2nd column
  colMean <- grep(".*mean..-.*", names(datAll))  ## NOTE: This removes the
  colStd  <- grep(".*std..-.*",  names(datAll))  ## meanFreq() variables
  colKeep <- names(datAll[sort(c(colAct, colType, colMean, colStd))])
  
  ## 2b. Pare down the data to the keeper variables
  datAll <- datAll %>% select(all_of(colKeep))
  
  ## 2c. Clean up
  rm(colAct)
  rm(colKeep)
  rm(colMean)
  rm(colStd)
  rm(colType)

  ## 3. Add the verbose activity names
  ## 3a. Create vector of activity names
  actVect <- namesAct[datAll$Activity, 2]
  
  ## 3b. Replace the codes with the words in DatAll
  datAll$Activity <- actVect
  
  ## 3c. Clean up
  rm(actVect)
  rm(namesAct)
  
  ## 3d. Write output
  write.table(datAll, "./Output/datAll.txt")
  
  ## 4. See #1 above for variable naming step
  
  ## 5. Create Tidy summary dataset of averages by activity & type
  ## 5a. Get list of variables to summarize
  datMeans <- datAll %>% 
    group_by(Activity, DataType) %>% 
    summarize_at(vars(names(datAll)[-(1:2)]), mean)
  
  ## Output the Tidy Table
  write.table(datMeans, "./Output/datMeans.txt")
}
