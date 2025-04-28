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

# Cross-tabulations (example relationships)
table(ThyroidCancerData$Gender, ThyroidCancerData$Stage)
table(ThyroidCancerData$Smoking, ThyroidCancerData$Stage)
table(ThyroidCancerData$Focality, ThyroidCancerData$Stage)
table(ThyroidCancerData$Risk, ThyroidCancerData$Recurred)

# Chi-Square Test between Smoking and Stage
chisq.test(table(ThyroidCancerData$Smoking, ThyroidCancerData$Stage))

chisq.test(table(ThyroidCancerData$Gender, ThyroidCancerData$Recurred))

# ANOVA test for Age across different Stages
anova_result <- aov(Age ~ Stage, data = ThyroidCancerData)
summary(anova_result)

# Load libraries
library(ggplot2)

# Histogram of Age
ggplot(ThyroidCancerData, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Age", x = "Age", y = "Count")

# Bar plot for Gender
ggplot(ThyroidCancerData, aes(x = Gender)) +
  geom_bar(fill = "lightgreen") +
  labs(title = "Gender Distribution", x = "Gender", y = "Count")

# Bar plot for Stage
ggplot(ThyroidCancerData, aes(x = Stage)) +
  geom_bar(fill = "salmon") +
  labs(title = "Cancer Stage Distribution", x = "Stage", y = "Count")

# Boxplot of Age across Stage
ggplot(ThyroidCancerData, aes(x = Stage, y = Age, fill = Stage)) +
  geom_boxplot() +
  labs(title = "Age Distribution across Cancer Stages", x = "Stage", y = "Age") +
  theme(legend.position = "none")

