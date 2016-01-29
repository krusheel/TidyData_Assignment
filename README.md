This project assumes the Human Activity Recognition data set is available in the root folder with name "UCI HAR Dataset"

1. First step of the script loads data from training and test folders of the dataset and combines training and test data. Combined data is stored in the variable combineddata

2. Measurements on mean and standard deviation on the combineddata from step 1 is obtained by selecting those variables whose names contains "mean()" or "std()"

3. train and test activity data is read and combined. Comined activity data is merged with the descriptive activity label name.

4. Descriptive names are assigned to the combined data from step 1. Step 4 is done part of step 2 by reading the features and assigning colummn names to data set from step 1

5. All features corresponding to an activity and subject are averaged and aved to har_dataset.txt

Codebook.md provides details about themns in transformations on human activity recognition dataset and columns of the data set.
