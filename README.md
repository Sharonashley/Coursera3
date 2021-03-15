# Coursera Getting and Cleaning Data course project

The included R script, run_analysis.R, does the following:

* reads in the dplyr library
* downloads the data from the website if the file name is not already in your working directory
* reads in x_train, y_train, x_test, y_test, subject_train and subject_test files
* columnbinds X and Y train sets, X and Y test sets, and subject train/test
* rowbinds train and test sets together to form 1 complete dataset
* reads in teh features.txt data
* pulls only those features that have mean or std in the title
* then keeps only those columns from the complpete data set
* renames activities from 1-6 to descriptive names
* creates a second summary dataset that calculates the mean for each measurement per activity and subject

An example of the clean, complete data set is shown in all_data.txt and an example of the tiny, summarized data is shown in summarized_data.txt. 



