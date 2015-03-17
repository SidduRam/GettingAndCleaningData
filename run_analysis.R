# Import the required data package & data tables
library(dplyr)
library(plyr)
require(data.table)

# Set the local working directory
path <- getwd()

pathIn <- file.path(path, "UCI HAR Dataset")
list.files(pathIn, recursive=TRUE)


# 1. Merge the 'Train' and 'Test' data into one dataset
#-------------------------------------------------------
dt_x_train <- read.table(file.path(pathIn, "train", "X_train.txt"))
dt_y_train <- read.table(file.path(pathIn, "train", "y_train.txt"))
dtSubjectTrain <- read.table(file.path(pathIn, "train", "subject_train.txt"))

dt_x_test <- read.table(file.path(pathIn, "test", "X_test.txt"))
dt_y_test <- read.table(file.path(pathIn, "test", "y_test.txt"))
dtSubjectTest <- read.table(file.path(pathIn, "test", "subject_test.txt"))

# create 'x' data set  ('Fearures' data)
dt_x_data <- rbind(dt_x_train, dt_x_test)

# create 'y' data set ('Activity' data)
dt_y_data <- rbind(dt_y_train, dt_y_test)

# create 'Subject' data set
dtSubject_data <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject_data, "V1", "subject")

# create 'activity' data set
dtActivity_data <- rbind(dt_y_train, dt_y_test) # 10299 Observations (Rows x 1 col)
setnames(dtActivity_data, "V1", "activity")

# Create 'fearures data' ('x')
dtFearures_data <- rbind(dt_x_train, dt_x_test)
setnames(dtFearures_data, "V1", "fearures")

# Merge the columns
dtSubject <- cbind(dtSubject_data, dtActivity_data)  
dt <- cbind(dtSubject, dtFearures_data)


# 2. Extract only the mean and standard deviation
#------------------------------------------------
dtfeatures <- read.table(file.path(path, "UCI HAR Dataset", "features.txt")) 
setnames(dtfeatures, names(dtfeatures), c("featureNum", "featureName"))

# Get the name which has only mean and std records
mean_std_features <- grep("-(mean|std)\\(\\)", dtfeatures[, 2])

# subset the records of mean and stds 
dt_x_data <- dt_x_data[, mean_std_features]

# correct the column names
names(dt_x_data) <- dtfeatures[mean_std_features, 2]  # 10299 x 66 (Rows x Cols)


# 3. Use descriptive activity names to name the activities in the data set
#-------------------------------------------------------------------------
drActivities <- read.table(file.path(path, "UCI HAR Dataset", "activity_labels.txt"))

# update values with correct activity names
dt_y_data[, 1] <- drActivities[dt_y_data[, 1], 2]

# Set the table name correct column name (# 10299 x 1 Observations (Rows x Cols) w/ Activity names)
names(dt_y_data) <- "activity" 


# 4. Appropriately labels the data set with descriptive variable names
#------------------------------------------------------------------------

# Merge all data sets using column bind (10299 x 68 Observations)
dt_all_data <- cbind(dtSubject_data, dt_x_data, dt_y_data)

names(dt_all_data)<-gsub("^t", "time", names(dt_all_data))
names(dt_all_data)<-gsub("^f", "frequency", names(dt_all_data))
names(dt_all_data)<-gsub("Acc", "Accelerometer", names(dt_all_data))
names(dt_all_data)<-gsub("Gyro", "Gyroscope", names(dt_all_data))
names(dt_all_data)<-gsub("Mag", "Magnitude", names(dt_all_data))
names(dt_all_data)<-gsub("BodyBody", "Body", names(dt_all_data))


# 5. Calculate the average of each variable for each activity and each subject
#------------------------------------------------------------------------------

# Create a 'Tidy' dataset
dt_tidy <- ddply(dt_all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Txt file with average 
write.table(dt_tidy, "Tidy_Mean.txt", row.name=FALSE)


