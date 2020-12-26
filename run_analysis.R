run_analysis <- function(){
  library(dplyr) ## Load library dplyr for working with tibbles
  
  ## LoadFrame function for loading the test and trial data.  Requires file locations for subject numbers,
  ## activity numbers, and test/training data (in that order).  Output is a tibble that includes subject 
  ## number, activity name, and data on all variables.
  LoadFrame <- function(loc1,loc2,loc3){
    SubNum <- read.table(loc1,col.names=c("subject"))
    Act <- read.table(loc2,col.names=c("activity"))
    Act$activity <- factor(Act$activity,labels=c("walking","upstairs","downstairs","sitting","standing","laying"))
    Data <- read.table(loc3)
    Data <- Data[,KeepVars]
    names(Data) <- VarNames[KeepVars]
    Data <- as_tibble(Data)
    Data <- mutate(Data,subject=SubNum$subject,activity=Act$activity)
    Data <- relocate(Data,subject:activity)
    return(Data)
  }
  
  ## Read in the variable names from the data set and extract those that are a calculated mean or
  ## standard deviation.
  VarNames <- as.character(read.table("UCI HAR Dataset/features.txt")$V2)
  KeepVars <- grep("mean\\(\\)|std\\(\\)",VarNames)
  
  ## File locations to input to LoadFrame to obtain test data
  loc1="UCI HAR Dataset/test/subject_test.txt"
  loc2="UCI HAR Dataset/test/y_test.txt"
  loc3="UCI HAR Dataset/test/X_test.txt"
  
  ## Load the test dataset
  TestData <- LoadFrame(loc1,loc2,loc3)
  
  
  ## File locations to input to LoadFrame to obtain training data
  loc1="UCI HAR Dataset/train/subject_train.txt"
  loc2="UCI HAR Dataset/train/y_train.txt"
  loc3="UCI HAR Dataset/train/X_train.txt"
  
  ## Load the training dataset
  TrainData <- LoadFrame(loc1,loc2,loc3)
  
  ## Combine test and training data into one complete dataset
  FinalData <- bind_rows(TestData,TrainData)
  
  # Revise variable names to meake them more descriptive
  NewNames <- sub("^t","TimeDomain",names(FinalData))
  NewNames <- sub("^f","FrequencyDomain",NewNames)
  NewNames <- sub("Acc","Accelerometer",NewNames)
  NewNames <- sub("Gyro","Gyroscope",NewNames)
  NewNames <- sub("Mag","Magnitude",NewNames)
  NewNames <- sub("-mean\\(\\)","Mean",NewNames)
  NewNames <- sub("-std\\(\\)","StandardDeviation",NewNames)
  NewNames <- sub("-X","Xdirection",NewNames)
  NewNames <- sub("-Y","Ydirection",NewNames)
  NewNames <- sub("-Z","Zdirection",NewNames)
  
  ## Update variable names with the revised versions
  names(FinalData) <- NewNames
  
  ## Group data by subject and activity, then find the mean for each combination of
  ## those variables
  Groups <- group_by(FinalData,subject,activity)
  GroupMeans <- summarize(Groups,across(everything(),mean))
  
  ## Update names again to note that means are displayed
  names(GroupMeans) <- c("subject","activity",lapply(NewNames[3:length(NewNames)]
      ,function(x){paste0("MeanOf",x)}))
  
  ## Output data to text file
  write.table(GroupMeans,file="ProjectOutput.txt",row.names=FALSE)
  
}