# Load dataset using read.csv
ThyroidCancerData <- read.csv("data/thyroid_dataset.csv", colClasses = c(
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
head(ThyroidCancerData)
View(ThyroidCancerData)

# Measures of Frequency
# Frequency tables for categorical variables
table(ThyroidCancerData$Gender)
table(ThyroidCancerData$Smoking)
table(ThyroidCancerData$Hx_Smoking)
table(ThyroidCancerData$Hx_Radiothreapy)
table(ThyroidCancerData$Thyroid_Function)
table(ThyroidCancerData$Physical_Examination)
table(ThyroidCancerData$Adenopathy)
table(ThyroidCancerData$Pathology)
table(ThyroidCancerData$Focality)
table(ThyroidCancerData$Risk)
table(ThyroidCancerData$Stage)
table(ThyroidCancerData$Response)
table(ThyroidCancerData$Recurred)

# Measures of Central Tendency
# Mean, Median, Mode (custom function) for Age
mean(ThyroidCancerData$Age)
median(ThyroidCancerData$Age)

# Mode function
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
get_mode(ThyroidCancerData$Age)

# Measures of Central Tendency
# Standard Deviation, Variance, Range, and Summary for Age
sd(ThyroidCancerData$Age)          # Standard deviation
var(ThyroidCancerData$Age)         # Variance
range(ThyroidCancerData$Age)        # Range (min and max)
summary(ThyroidCancerData$Age)      # Min, 1st Qu., Median, Mean, 3rd Qu., Max



