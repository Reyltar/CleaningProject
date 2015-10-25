---
title: "README.md"
author: "G. Ozanne"
date: "25 octobre 2015"
---
---


## Getting & Cleaning Data
### Course project

Prerequisite : We assume that the Samsung data set has been unzip in the working directory  
  
#### Description  : run_analysis.R

The script is structured into 6 steps :  

* Step 0 : Identify usefull columns (mean & std deviation) for the assignment  
    * features.txt is load into **featuresFile**  
    * grep function is used to find rows which contain "mean" or "std"  
    * identified rows are stored into **columnFilter**  
      <br/>
      
* Step 1 : Create tidy data with X and Y files from test directory  
    * X_test.txt and Y_test.txt are stored into **x_testFile** and **y_testFile**  
    * subject_test.txt is stored into **subject_testFile**
    * each columns of **x_testFile** which are contained in **columnFilter** are merged into **x_testFileFiltered**
    * each columns of **x_testFileFiltered** are renamed with descriptions from **columnFilter**  
    * a tidy data set **testData** is created with by merging : **y_testFile**, **subject_testFile** and **x_testFileFiltered**  
      <br/>
      
* Step 2 : Create tidy data with X and Y files from train directory
    * R code is identical to step 1, variable names use the pattern *train* instead of *test*  
    * [...]  
      <br/>
      
* Step 3 : Merge previous data into a unique data set  
    * **testData** and **trainData** are merged into **UniqueDataSet**  
      <br/>
      
* Step 4 : Add descriptive labels for activity and subject  
    * each *activity* id from **UniqueDataSet** are replace with gsub function  
    * *subject* column from **UniqueDataSet** is renamed into *Subject_ID*  
      <br/>
      
* Step 5 : Create a data set with the average of each variable for each activity and each subject
    * use dplyr package to group by and summarise by *Subject_ID* and *Activity*  
    * export result into Tidy_data_set.txt with write.table function