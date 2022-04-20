# BUSINESS SCIENCE UNIVERSITY
# DS4B 203-R: ADVANCED TIME SERIES FORECASTING FOR BUSINESS
# MODULE: TIME SERIES JUMPSTART 

# GOAL: Forecast Daily Email Users - Next 8-WEEKS

# OBJECTIVES ----
# - Dive into a time-series analysis project
# - Experience Frameworks: modeltime
# - Experience 2 Algorithms:
#   1. Prophet
#   2. LM w/ Engineered Features

# LIBRARIES ----

library(tidymodels)
library(modeltime)
library(DataExplorer)
library(tidyverse)
library(timetk)
library(lubridate)

# DATA -----

mailchimp_users <- read_rds(here("data/mailchimp_users.rds"))

# 1.0 EDA & DATA PREP ----
# * DAILY SUBSCRIBERS INCREASES

glimpse(mailchimp_users)

## 1.1 Count of Opt-ins by Day ----

optins_day <- mailchimp_users %>%
  summarise_by_time(
    .date_var = optin_time,
    by = "day",
    optins = n()
  )

## 1.2 Summary Diagnostics ----

tk_summary_diagnostics(optins_day, .date_var = optin_time)

## 1.3 Pad the Time Series ----

optins_day_prepared <- pad_by_time(.data = optins_day, 
                                   .pad_value = 0, 
                                   .date_var = optin_time,
                                   .by = "day")

## 1.4 Visualization ----

plot_time_series(.data = optins_day_prepared,
                 .date_var = optin_time,
                 .value = optins)

# 2.0 EVALUATION PERIOD ----

## 2.1 Filtering ----

evaluation <- filter_by_time(.data = optins_day_prepared,
                             .date_var = optin_time,
                             .start_date = "2018-11-20",
                             .end_date = "end")

plot_time_series(evaluation, .date_var = optin_time, .value = optins)

## 2.2 Train/Test ----

splits <- time_series_split(
  data = evaluation,
  date_var = optin_time,
  assess = "8 week",
  cumulative = TRUE
)

splits %>%
  tk_time_series_cv_plan() %>%
  plot_time_series_cv_plan(.date_var = optin_time,
                           .value = optins)

# 3.0 PROPHET FORECASTING ----

## 3.1 Prophet Model using Modeltime/Parsnip

model_prophet_fit <- prophet_reg() %>%
  set_engine("prophet") %>%
  fit(optins ~ optin_time, data = training(splits))

## 3.2 Modeltime Process ----

modeltime_table(
  model_prophet_fit
)

# 4.0 FORECASTING WITH FEATURE ENGINEERING ----





# 5.0 SUMMARY & NEXT STEPS ----

# * What you've learned ----
# - You've been exposed to:
#   - Tidymodels / Modeltime Framework
# - You've seen 2 modeling approaches:
#   - Prophet - Univariate, Automatic
#   - Linear Regression Model - Many recipe steps
# - You've experienced Feature Engineering
#   - Visualizations: ACF, Seasonality
#   - Feature Engineering from Date Variables
#
# * Where you are going! ----
# - You still need to learn:
#   - New algorithms
#   - Machine Learning - How to tune parameters
#   - Feature Engineering Strategies
#   - Ensembling - Competition winning strategy
#   - and a lot more!

