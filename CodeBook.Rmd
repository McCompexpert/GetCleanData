# CodeBook for the Getting and Cleaning Data
This CodeBook describes the variables, the data, and any transformations or work that I have performed to clean up the data. 

# Data Source

* Source website with comprehensive description of the used data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* Data for the project could be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Used transformations

1. I read in all files from the data zip, compared their dimensions and ended up
using only X_train.txt, y_train.txt and subject_train.txt from the ./data/train zip subfolder for the train data and X_test.txt, y_test.txt and subject_test.txt from the ./data/test zip subfolder 

2. Headers (=column names) for both train and test datasets are located in features.txt

3. Read in subject and activity datasets, use cbind() to put everything in a train or test dataframes.

4. Merge train and test dataframes by using rbind()

5. Read in activity labels and use them to overwrite activity IDs in the merged dataset for readablity purpose.

6. To extract columns with Mean and Standard Deviation measurements we use the grep() funcion, afterwards we provide to the columns readable names.

7. We use aggregate() and the function mean inside to get our tidy data.

8. Last step is to write the tidy dataframe as a csv.