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

# Load required package
library(caret)

# Set random seed for reproducibility
set.seed(123)

# Split data: 80% training, 20% testing
trainIndex <- createDataPartition(ThyroidCancerData$Stage, p = 0.8, list = FALSE)

trainData <- ThyroidCancerData[trainIndex, ]
testData <- ThyroidCancerData[-trainIndex, ]

# Check dimensions
dim(trainData)
dim(testData)

# Set up bootstrapping
set.seed(123)
bootstrap_ctrl <- trainControl(method = "boot", number = 100) # 100 bootstrap resamples

# Example: (We will reuse this when training models)
model_boot <- train(Stage ~ ., data = trainData, method = "rf", trControl = bootstrap_ctrl)

print(model_boot)

# Set up 10-fold cross-validation
set.seed(123)
cv_ctrl <- trainControl(method = "cv", number = 10)  # 10-fold CV

# Example: (we will reuse this for models)
model_cv <- train(Stage ~ ., data = trainData, method = "rf", trControl = cv_ctrl)

print(model_cv)