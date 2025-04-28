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

