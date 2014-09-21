##Code Book for project
## Data Set Names:
This data set tries to consolidate the information as averages of their corresponding variables from training and test data sets. The "inertial signals" have not been taken in account. </p>


##Following steps were taken to read training and test data </p>

data_train : X-train data

data_test : X-test data

sub_train : Subjects for training

sub_test : Subjects for test

y_train : Activities for training.

y_test : Activities for test.

Combining Data
	Merged all training data using cbind and stored in "completeTraining"
	Merged all test data using cbind and stored in "completeTest"
	Merged all training and test data using rbind.


 Read features for column headers

 only selected columns pertaining mean and std

 Read Activity table

 Replace activity numbers by activity names


 Split by subject and activity

 Apply colMeans() on each variable using "lapply"

 Write table to a text file called "averages.txt" in the working directory.



