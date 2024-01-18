# Getting-and-Cleaning-Data-Course-Project
Git repo for Getting and Cleaning Data class

**Readme notes for Getting & Cleaning Data course project**
TMP 1/17/24

This project generates a high-level summarized data set based on the summary datasets provided in the "Human Activity Recognition Using Smartphones" Version 1.0 dataset [1]. See the Data/UCI HAR Dataset/readme.txt file for details on how the summary datasets were produced.

The data was obtained from here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data was downloaded and is now located within the "Data/UCI HAR Dataset" directory of this project.

The output of this project is ./Output/datMeans.txt

The output file contains a summary of the summary data provided in the source files. The contents of the file are outlined in the CodeBook.rmd file located in ./Scripts/CodeBook.Rmd (or [./Scripts/CodeBook.html](https://htmlpreview.github.io/?https://github.com/t-pee/Getting-and-Cleaning-Data-Course-Project/blob/main/Scripts/CodeBook.html)).

The R code used to generate the output lives in the CodeBook.Rmd file, as well as the main() function in run_analysis.R.

Analysis of the data and conclusions are out of scope for this project.

------------------------------------
References:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
