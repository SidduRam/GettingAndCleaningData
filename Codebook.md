### Code-Book to create ‘Tidy’ dataset

Aim of this code book is to explain how the data is pre-processed before data analysis is done step-by-step. Also, the variable description and relevant data summaries are included here to explain how the result has been arrived. You can follow the same steps to see/create the ‘Tidy’ data of average value of each ‘Activity’ and ‘Subject’ measures. 

#### Data Source: 
Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip <br>
Description of this dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### Data Set Information:

Data has been collected from a group of volunteers performing the following six activities - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, using embedded accelerometer and gyroscope on a smartphone (thru Wearable computing). This data is captured in all 3-axial linear acceleration and 3-axial angular velocity at a constant rate. This data sampled with fixed-width after pre-processing by applying noise filters. 
######The Key data:<br>
The “UCI HAR Dataset" dataset has the following key files. Some of these files are available for the train and test data:<br>
•	'activity_labels.txt': Links the class labels with their activity name.<br>
•	'features_info.txt': Shows information about the variables used on the feature vector.<br>
•	'features.txt': List of all features.<br>
•	Features <br>
  o	'train/X_train.txt': Training set.<br>
  o	'test/X_test.txt': Test set.<br>
•	Activity<br>
  o	'train/y_train.txt': Training labels.<br>
  o	'test/y_test.txt': Test labels.<br>
•	Subject<br>
  o	'train/subject_train.txt': Each observation identifies the subject who performed the activity for each sample. <br>
  o	'test/ subject_test.txt': Test labels.<br>
  
####  Data Transformation steps
1.	Merges the training and the test sets (Subject, Activity and Features) to create one combined data set.<br>
2.	Extracts only the measurements on the mean and standard deviation for each measurement.<br>
3.	Uses descriptive activity names (Walking, Walking upstairs, Walking downstairs, Sitting, and Laying) to name the activities in the data set.<br>
4.	Appropriately labels the data set with descriptive activity names.<br>
5.	Create a Tidy dataset which holds the average value of each variable for each activity and each subject.<br>

#### To Run the analysis (<I>Implementation steps</I>):
The run_analysis.R source fie has the co/de for ‘how implement the above steps’ and generate the ‘tidy’ average for each activity and subject.<br>
•	Require dplyr, plyr and data.table libraries.<br>
•	Set the local working directory, and underneath the subfolder – “UCI HAR Dataset” should have downloaded dataset all key files listed above.<br>
•	Load both test and train data for Subject, Activity and Features<br>
•	Load the features (features.txt) and extract the mean and standard deviation column names with data<br>
•	Load the activity (activity_labels.txt) and the set the descriptive activity names for ‘Activity’ data (combined data of ‘y_train.txt’ & ‘y_test.txt’))<br>
•	Set the descriptive ‘Full’  name for all key variable in the combined dataset using ‘gsub’ function<br>
•	Calculate the average of each ‘activity’ and ‘subject’ and use that data to create a ‘tidy’ dataset.  <br>
•	Store the ‘tidy’ dataset as ‘Tidy_Mean.txt’ file and uploaded in GitHub <br>

