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

# Load necessary libraries
library(randomForest)
library(caret)

# Set random seed
set.seed(123)

# Train Random Forest
rf_model <- train(Stage ~ ., 
                  data = trainData,
                  method = "rf",
                  trControl = cv_ctrl)

# Print results
print(rf_model)

# Load xgboost package
library(xgboost)

# Since xgboost expects numeric data, first ensure factors are properly encoded
# (caret will internally handle this if using train())

# Train XGBoost
set.seed(123)
xgb_model <- train(Stage ~ ., 
                   data = trainData,
                   method = "xgbTree",
                   trControl = cv_ctrl)

# Print results
print(xgb_model)

# Load nnet package for multinomial logistic regression
library(nnet)

# Train Multinomial Logistic Regression
set.seed(123)
multinom_model <- train(Stage ~ ., 
                        data = trainData,
                        method = "multinom",
                        trControl = cv_ctrl,
                        trace = FALSE)  # suppress output during training

# Print results
print(multinom_model)


# Load required library
library(caret)

# Assume you have trained models already, like:
# rf_model, svm_model, xgb_model

# 1. Collect models into a list
models_list <- list(
  RandomForest = rf_model,
  Multinom = multinom_model,
  XGBoost = xgb_model
)

# 2. Compare model performance
model_comparison <- resamples(models_list)

# 3. Summary of results
summary(model_comparison)

# 4. Visualization of comparison
bwplot(model_comparison, metric = "Accuracy")  # Boxplot of Accuracy
dotplot(model_comparison, metric = "Accuracy") # Dotplot of Accuracy

# You can also check Kappa scores if needed
bwplot(model_comparison, metric = "Kappa")
dotplot(model_comparison, metric = "Kappa")
