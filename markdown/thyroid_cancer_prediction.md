Thyroid Cancer Prediction
================
Trevor Okinda
2024

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
  - [Source:](#source)
  - [Reference:](#reference)
- [Understanding the Dataset (Exploratory Data Analysis
  (EDA))](#understanding-the-dataset-exploratory-data-analysis-eda)
  - [Loading the Dataset](#loading-the-dataset)
  - [Measures of Frequency](#measures-of-frequency)
  - [Measures of Central Tendency](#measures-of-central-tendency)
  - [Measures of Distribution](#measures-of-distribution)
  - [ANOVA](#anova)
  - [Plots](#plots)
- [Preprocessing & Data
  Transformation](#preprocessing--data-transformation)
  - [Missing Values](#missing-values)
- [Training Model](#training-model)
  - [Data Splitting](#data-splitting)

# Student Details

|                       |                           |
|-----------------------|---------------------------|
| **Student ID Number** | 134780                    |
| **Student Name**      | Trevor Okinda             |
| **BBIT 4.2 Group**    | C                         |
| **Project Name**      | Thyroid Cancer Prediction |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

### Source:

The dataset that was used can be downloaded here: *\<<a
href="https://www.kaggle.com/datasets/zaraavagyan/weathercsv/discussion\"
class="uri">https://www.kaggle.com/datasets/zaraavagyan/weathercsv/discussion\</a>\>*

### Reference:

*\<Avagyan, Z. (2017). Weather CSV \[Data set\]. Kaggle.
<a href="https://www.kaggle.com/datasets/zaraavagyan/weathercsv\"
class="uri">https://www.kaggle.com/datasets/zaraavagyan/weathercsv\</a>\>  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

# Understanding the Dataset (Exploratory Data Analysis (EDA))

## Loading the Dataset

``` r
# Load dataset using read.csv
ThyroidCancerData <- read.csv("thyroid_dataset.csv", colClasses = c(
  Age = "numeric",
  Gender = "factor",
  Smoking = "factor",
  Hx_Smoking = "factor",
  Hx_Radiothreapy = "factor",
  Thyroid_Function = "factor",
  Physical_Examination = "factor",
  Adenopathy = "factor",
  Pathology = "factor",
  Focality = "factor",
  Risk = "factor",
  T = "factor",
  N = "factor",
  M = "factor",
  Stage = "factor",
  Response = "factor",
  Recurred = "factor"
))

# Preview the structure and a few rows
str(ThyroidCancerData)
```

    ## 'data.frame':    383 obs. of  17 variables:
    ##  $ Age                 : num  27 34 30 62 62 52 41 46 51 40 ...
    ##  $ Gender              : Factor w/ 2 levels "F","M": 1 1 1 1 1 2 1 1 1 1 ...
    ##  $ Smoking             : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 2 1 1 1 1 ...
    ##  $ Hx_Smoking          : Factor w/ 2 levels "No","Yes": 1 2 1 1 1 1 2 1 1 1 ...
    ##  $ Hx_Radiothreapy     : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Thyroid_Function    : Factor w/ 5 levels "Clinical Hyperthyroidism",..: 3 3 3 3 3 3 1 3 3 3 ...
    ##  $ Physical_Examination: Factor w/ 5 levels "Diffuse goiter",..: 4 2 5 5 2 2 5 5 5 5 ...
    ##  $ Adenopathy          : Factor w/ 6 levels "Bilateral","Extensive",..: 4 4 4 4 4 4 4 4 4 4 ...
    ##  $ Pathology           : Factor w/ 4 levels "Follicular","Hurthel cell",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ Focality            : Factor w/ 2 levels "Multi-Focal",..: 2 2 2 2 1 1 2 2 2 2 ...
    ##  $ Risk                : Factor w/ 3 levels "High","Intermediate",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ T                   : Factor w/ 7 levels "T1a","T1b","T2",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ N                   : Factor w/ 3 levels "N0","N1a","N1b": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ M                   : Factor w/ 2 levels "M0","M1": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Stage               : Factor w/ 5 levels "I","II","III",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Response            : Factor w/ 4 levels "Biochemical Incomplete",..: 3 2 2 2 2 3 2 2 2 2 ...
    ##  $ Recurred            : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...

``` r
head(ThyroidCancerData)
```

    ##   Age Gender Smoking Hx_Smoking Hx_Radiothreapy Thyroid_Function
    ## 1  27      F      No         No              No        Euthyroid
    ## 2  34      F      No        Yes              No        Euthyroid
    ## 3  30      F      No         No              No        Euthyroid
    ## 4  62      F      No         No              No        Euthyroid
    ## 5  62      F      No         No              No        Euthyroid
    ## 6  52      M     Yes         No              No        Euthyroid
    ##          Physical_Examination Adenopathy      Pathology    Focality Risk   T  N
    ## 1  Single nodular goiter-left         No Micropapillary   Uni-Focal  Low T1a N0
    ## 2         Multinodular goiter         No Micropapillary   Uni-Focal  Low T1a N0
    ## 3 Single nodular goiter-right         No Micropapillary   Uni-Focal  Low T1a N0
    ## 4 Single nodular goiter-right         No Micropapillary   Uni-Focal  Low T1a N0
    ## 5         Multinodular goiter         No Micropapillary Multi-Focal  Low T1a N0
    ## 6         Multinodular goiter         No Micropapillary Multi-Focal  Low T1a N0
    ##    M Stage      Response Recurred
    ## 1 M0     I Indeterminate       No
    ## 2 M0     I     Excellent       No
    ## 3 M0     I     Excellent       No
    ## 4 M0     I     Excellent       No
    ## 5 M0     I     Excellent       No
    ## 6 M0     I Indeterminate       No

``` r
View(ThyroidCancerData)
```

## Measures of Frequency

``` r
# Measures of Frequency
# Frequency tables for categorical variables
table(ThyroidCancerData$Gender)
```

    ## 
    ##   F   M 
    ## 312  71

``` r
table(ThyroidCancerData$Smoking)
```

    ## 
    ##  No Yes 
    ## 334  49

``` r
table(ThyroidCancerData$Hx_Smoking)
```

    ## 
    ##  No Yes 
    ## 355  28

``` r
table(ThyroidCancerData$Hx_Radiothreapy)
```

    ## 
    ##  No Yes 
    ## 376   7

``` r
table(ThyroidCancerData$Thyroid_Function)
```

    ## 
    ##    Clinical Hyperthyroidism     Clinical Hypothyroidism 
    ##                          20                          12 
    ##                   Euthyroid Subclinical Hyperthyroidism 
    ##                         332                           5 
    ##  Subclinical Hypothyroidism 
    ##                          14

``` r
table(ThyroidCancerData$Physical_Examination)
```

    ## 
    ##              Diffuse goiter         Multinodular goiter 
    ##                           7                         140 
    ##                      Normal  Single nodular goiter-left 
    ##                           7                          89 
    ## Single nodular goiter-right 
    ##                         140

``` r
table(ThyroidCancerData$Adenopathy)
```

    ## 
    ## Bilateral Extensive      Left        No Posterior     Right 
    ##        32         7        17       277         2        48

``` r
table(ThyroidCancerData$Pathology)
```

    ## 
    ##     Follicular   Hurthel cell Micropapillary      Papillary 
    ##             28             20             48            287

``` r
table(ThyroidCancerData$Focality)
```

    ## 
    ## Multi-Focal   Uni-Focal 
    ##         136         247

``` r
table(ThyroidCancerData$Risk)
```

    ## 
    ##         High Intermediate          Low 
    ##           32          102          249

``` r
table(ThyroidCancerData$Stage)
```

    ## 
    ##   I  II III IVA IVB 
    ## 333  32   4   3  11

``` r
table(ThyroidCancerData$Response)
```

    ## 
    ## Biochemical Incomplete              Excellent          Indeterminate 
    ##                     23                    208                     61 
    ##  Structural Incomplete 
    ##                     91

``` r
table(ThyroidCancerData$Recurred)
```

    ## 
    ##  No Yes 
    ## 275 108

## Measures of Central Tendency

``` r
# Measures of Central Tendency
# Mean, Median, Mode (custom function) for Age
mean(ThyroidCancerData$Age)
```

    ## [1] 40.86684

``` r
median(ThyroidCancerData$Age)
```

    ## [1] 37

``` r
# Mode function
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
get_mode(ThyroidCancerData$Age)
```

    ## [1] 31

## Measures of Distribution

``` r
# Measures of Central Tendency
# Standard Deviation, Variance, Range, and Summary for Age
sd(ThyroidCancerData$Age)          # Standard deviation
```

    ## [1] 15.13449

``` r
var(ThyroidCancerData$Age)         # Variance
```

    ## [1] 229.0529

``` r
range(ThyroidCancerData$Age)        # Range (min and max)
```

    ## [1] 15 82

``` r
summary(ThyroidCancerData$Age)      # Min, 1st Qu., Median, Mean, 3rd Qu., Max
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   15.00   29.00   37.00   40.87   51.00   82.00

``` r
# Cross-tabulations (example relationships)
table(ThyroidCancerData$Gender, ThyroidCancerData$Stage)
```

    ##    
    ##       I  II III IVA IVB
    ##   F 284  20   2   1   5
    ##   M  49  12   2   2   6

``` r
table(ThyroidCancerData$Smoking, ThyroidCancerData$Stage)
```

    ##      
    ##         I  II III IVA IVB
    ##   No  308  21   1   0   4
    ##   Yes  25  11   3   3   7

``` r
table(ThyroidCancerData$Focality, ThyroidCancerData$Stage)
```

    ##              
    ##                 I  II III IVA IVB
    ##   Multi-Focal  95  25   3   3  10
    ##   Uni-Focal   238   7   1   0   1

``` r
table(ThyroidCancerData$Risk, ThyroidCancerData$Recurred)
```

    ##               
    ##                 No Yes
    ##   High           0  32
    ##   Intermediate  38  64
    ##   Low          237  12

## ANOVA

``` r
# Chi-Square Test between Smoking and Stage
chisq.test(table(ThyroidCancerData$Smoking, ThyroidCancerData$Stage))
```

    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  table(ThyroidCancerData$Smoking, ThyroidCancerData$Stage)
    ## X-squared = 81.508, df = 4, p-value < 2.2e-16

``` r
chisq.test(table(ThyroidCancerData$Gender, ThyroidCancerData$Recurred))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(ThyroidCancerData$Gender, ThyroidCancerData$Recurred)
    ## X-squared = 39.397, df = 1, p-value = 3.459e-10

``` r
# ANOVA test for Age across different Stages
anova_result <- aov(Age ~ Stage, data = ThyroidCancerData)
summary(anova_result)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)    
    ## Stage         4  29766    7442   48.72 <2e-16 ***
    ## Residuals   378  57732     153                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## Plots

``` r
# Load libraries
library(ggplot2)

# Histogram of Age
ggplot(ThyroidCancerData, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Age", x = "Age", y = "Count")
```

![](thyroid_cancer_prediction_files/figure-gfm/Plots-1.png)<!-- -->

``` r
# Bar plot for Gender
ggplot(ThyroidCancerData, aes(x = Gender)) +
  geom_bar(fill = "lightgreen") +
  labs(title = "Gender Distribution", x = "Gender", y = "Count")
```

![](thyroid_cancer_prediction_files/figure-gfm/Plots-2.png)<!-- -->

``` r
# Bar plot for Stage
ggplot(ThyroidCancerData, aes(x = Stage)) +
  geom_bar(fill = "salmon") +
  labs(title = "Cancer Stage Distribution", x = "Stage", y = "Count")
```

![](thyroid_cancer_prediction_files/figure-gfm/Plots-3.png)<!-- -->

``` r
# Boxplot of Age across Stage
ggplot(ThyroidCancerData, aes(x = Stage, y = Age, fill = Stage)) +
  geom_boxplot() +
  labs(title = "Age Distribution across Cancer Stages", x = "Stage", y = "Age") +
  theme(legend.position = "none")
```

![](thyroid_cancer_prediction_files/figure-gfm/Plots-4.png)<!-- -->

# Preprocessing & Data Transformation

## Missing Values

``` r
# Check if there are any missing values
any(is.na(ThyroidCancerData))
```

    ## [1] FALSE

``` r
# Summary of missing values per column
colSums(is.na(ThyroidCancerData))
```

    ##                  Age               Gender              Smoking 
    ##                    0                    0                    0 
    ##           Hx_Smoking      Hx_Radiothreapy     Thyroid_Function 
    ##                    0                    0                    0 
    ## Physical_Examination           Adenopathy            Pathology 
    ##                    0                    0                    0 
    ##             Focality                 Risk                    T 
    ##                    0                    0                    0 
    ##                    N                    M                Stage 
    ##                    0                    0                    0 
    ##             Response             Recurred 
    ##                    0                    0

``` r
# Visualize missing values (optional)
# Install if needed: install.packages("Amelia")
library(Amelia)
```

    ## Loading required package: Rcpp

    ## ## 
    ## ## Amelia II: Multiple Imputation
    ## ## (Version 1.8.1, built: 2022-11-18)
    ## ## Copyright (C) 2005-2025 James Honaker, Gary King and Matthew Blackwell
    ## ## Refer to http://gking.harvard.edu/amelia/ for more information
    ## ##

``` r
missmap(ThyroidCancerData, main = "Missing Values Map", col = c("red", "green"), legend = FALSE)
```

![](thyroid_cancer_prediction_files/figure-gfm/Missing%20values-1.png)<!-- -->

# Training Model

## Data Splitting

``` r
# Load required package
library(caret)
```

    ## Loading required package: lattice

``` r
# Set random seed for reproducibility
set.seed(123)

# Split data: 80% training, 20% testing
trainIndex <- createDataPartition(ThyroidCancerData$Stage, p = 0.8, list = FALSE)

trainData <- ThyroidCancerData[trainIndex, ]
testData <- ThyroidCancerData[-trainIndex, ]

# Check dimensions
dim(trainData)
```

    ## [1] 309  17

``` r
dim(testData)
```

    ## [1] 74 17
