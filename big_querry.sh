#!/bin/bash
# bigquery.sh
# Common BigQuery operations using the bq CLI and gcloud
# Usage: ./bigquery.sh

# ---- Configuration ----
PROJECT_ID="your-project-id"
DATASET_ID="student_data"
TABLE_ID="student_performance"
LOCATION="US"
BUCKET_NAME="your-bucket-name"
CSV_FILE="gs://${BUCKET_NAME}/students.csv"

# ---- 1. Create a Dataset ----
create_dataset() {
  echo "Creating dataset: $DATASET_ID"
  bq --location=$LOCATION mk \
    --dataset \
    --description "Student performance dataset" \
    ${PROJECT_ID}:${DATASET_ID}
}

# ---- 2. Create a Table with Schema ----
create_table() {
  echo "Creating table: $TABLE_ID"
  bq mk \
    --table \
    ${PROJECT_ID}:${DATASET_ID}.${TABLE_ID} \
    student_id:STRING,name:STRING,marks:FLOAT,attendance:FLOAT,result:STRING
}

# ---- 3. Load Data from GCS (CSV) into BigQuery ----
load_data_from_gcs() {
  echo "Loading data from $CSV_FILE into ${TABLE_ID}"
  bq load \
    --source_format=CSV \
    --skip_leading_rows=1 \
    --autodetect \
    ${PROJECT_ID}:${DATASET_ID}.${TABLE_ID} \
    $CSV_FILE
}
