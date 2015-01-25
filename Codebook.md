#Averages of the means and standard deviations for Samsung phone data grouped by subject and activity type

##Study design
Data was downloaded from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The test data set was read and combined with the subject, activity types, and features files. Similarly,
the training data set was read into a different table. Afterwards both tables, test and training were
combined into a single allData table, which was further processed.

From the allData table, all means and standard deviation columns were preserved, and the rest dropped.
The subject and the activity columns were also preserved and later the data was grouped by these columns
in order to compute the averages.

##Code book
Here is a description of the columns in the tidy data set:

