# plumber.R

# Load required libraries
library(plumber)
library(xgboost)
library(caret)

# Load the saved XGBoost model
loaded_xgb_model <- readRDS("./models/best_xgb_model.rds")

#* @apiTitle Thyroid Cancer Stage Prediction API
#* @apiDescription Predict the stage of thyroid cancer based on patient data.

#* @param Age Numeric age of the patient
#* @param Gender Gender (e.g., M or F)
#* @param Smoking Smoking status (Yes or No)
#* @param Hx_Smoking History of smoking (Yes or No)
#* @param Hx_Radiotherapy History of radiotherapy (Yes or No)
#* @param Thyroid_Function Thyroid function status
#* @param Physical_Examination Physical examination result
#* @param Adenopathy Presence of adenopathy (Yes or No)
#* @param Pathology Pathology result (e.g., Micropapillary)
#* @param Focality Focality (e.g., Uni-Focal or Multi-Focal)
#* @param Risk Risk level (Low/Intermediate/High)
#* @param T Tumor size category (e.g., T1a)
#* @param N Lymph node involvement (e.g., N0)
#* @param M Metastasis status (e.g., M0)
#* @param Response Treatment response (Excellent/Indeterminate/Incomplete)
#* @param Recurred Whether cancer has recurred (Yes/No)

#* @get /predict_stage
function(Age, Gender, Smoking, Hx_Smoking, Hx_Radiotherapy, Thyroid_Function,
         Physical_Examination, Adenopathy, Pathology, Focality, Risk, T, N, M,
         Response, Recurred) {
  
  # Create data frame from input parameters
  input_data <- data.frame(
    Age = as.numeric(Age),
    Gender = as.factor(Gender),
    Smoking = as.factor(Smoking),
    Hx_Smoking = as.factor(Hx_Smoking),
    Hx_Radiotherapy = as.factor(Hx_Radiotherapy),
    Thyroid_Function = as.factor(Thyroid_Function),
    Physical_Examination = as.factor(Physical_Examination),
    Adenopathy = as.factor(Adenopathy),
    Pathology = as.factor(Pathology),
    Focality = as.factor(Focality),
    Risk = as.factor(Risk),
    T = as.factor(T),
    N = as.factor(N),
    M = as.factor(M),
    Response = as.factor(Response),
    Recurred = as.factor(Recurred)
  )
  
  # Predict using loaded model
  prediction <- predict(loaded_xgb_model, newdata = input_data)
  
  # Return predicted stage
  list(predicted_stage = prediction)
}
