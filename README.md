# week4
First I identified the files I downloaded from the zip file provided by instructor. Relevant ones were:
activity_labels.txt - provided as the basis for looking up number to activity description
features.txt - provided to help label the columns with the correct activity description

each folder of "test" and "train" respectively contained the following used files:
X_test.txt or X_train.txt - the raw values of data
Y_train or Y_test.txt - provides identification of the subject (1-30) who was doing activity
subject_test.txt or subject_train.txt - identifies which subject was doing which activity for each row 

Each variable used in the analysis can be identified using the codebook in the repo. However, each variable included HERE indicates the AVERAGE value of that variable by SUBJECT and ACTIVITY. 

The code first searches for the desired columns of activity based on variable names including string "mean()" or "std()"
We identify the indices corresponding to matching hits, and extract those columns of X.txt files
We append activity and subject information separately for the training and test sets.

We then combine the two together.
Then we use dplyr package functions group_by and summarize_all to obtain desired output. 



