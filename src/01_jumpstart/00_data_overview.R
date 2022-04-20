# BUSINESS SCIENCE UNIVERSITY
# DS4B 203-R: ADVANCED TIME SERIES FORECASTING FOR BUSINESS
# MODULE: INSPECT COURSE DATASETS


# LIBRARIES ----
library(tidyverse)
library(here)

# DATA -----

# * Establish Relationships ----
#   - Website traffic (Page Views, Sessions, Organic Traffic)
#   - Top 20 Pages

read_rds(here("data/google_analytics_summary_hourly.RDS"))
read_rds(here("data/google_analytics_by_page_daily.RDS"))

# * Build Relationships ----
#   - Collect emails
#   - Host Events

# Mailchimp data
read_rds(here("data/mailchimp_users.rds"))

# Learning Labs
read_rds(here("data/learning_labs.rds"))

# * Generate Course Revenue ----
#   - Revenue data (aggregated at weekly interval)
#   - Product Events

# Transactions Weekly
read_rds(here("data/transactions_weekly.rds"))

# Product Events
read_rds(here("data/product_events.rds"))
