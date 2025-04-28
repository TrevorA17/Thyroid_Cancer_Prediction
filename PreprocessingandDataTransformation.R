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

# Check if there are any missing values
any(is.na(ThyroidCancerData))

# Summary of missing values per column
colSums(is.na(ThyroidCancerData))

# Visualize missing values (optional)
# Install if needed: install.packages("Amelia")
library(Amelia)
missmap(ThyroidCancerData, main = "Missing Values Map", col = c("red", "green"), legend = FALSE)
