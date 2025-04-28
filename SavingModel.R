# Save the best model (XGBoost in this case)
saveRDS(xgb_model, "./models/best_xgb_model.rds")

# Load the saved XGBoost model when needed
loaded_xgb_model <- readRDS("./models/best_xgb_model.rds")

# Example of prediction with the loaded model:
new_data <- data.frame(
  Age = 45,
  Gender = "M",  # or factor(1) for Male, or factor("M") depending on how you encoded
  Smoking = "No",
  Hx_Smoking = "No",
  Hx_Radiothreapy = "No",
  Thyroid_Function = "Euthyroid",
  Physical_Examination = "Single nodular goiter-left",
  Adenopathy = "No",
  Pathology = "Micropapillary",
  Focality = "Uni-Focal",
  Risk = "Low",
  T = "T1a",
  N = "N0",
  M = "M0",
  Response = "Excellent",
  Recurred = "No"
)

# Predict using the loaded model
prediction <- predict(loaded_xgb_model, newdata = new_data)

# Print prediction result
print(prediction)
