# Introduction

The run_analysis.R does the following:

* Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
* Load the feature info
* Loads the activity and subject data for each dataset, and merges those columns with the dataset
* Merges the tree datasets
* Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
* The end result is shown in the file tidy.txt.

# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_train_test`, `y_train_test` and `subject_train_test` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_train_test` dataset, which are applied to the column names stored in `features_mean_std`, a numeric vector used to extract the desired data.
* `subset_x_train_test` is a subset of the `x_train_test` only with the columns stored in `features_mean_std`.
* A similar approach is taken with activity names through the `activitiy` variable.
* `dataset` merges `subset_x_train_test`, `y_train_test` and `subject_train_test` in a big dataset.
* Finally, `tidy_data` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.