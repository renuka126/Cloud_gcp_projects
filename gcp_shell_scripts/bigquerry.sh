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

# ---- 4. Run a Query ----
run_query() {
  echo "Running query on ${TABLE_ID}"
  bq query --use_legacy_sql=false \
  "SELECT name, marks, result
   FROM \`${PROJECT_ID}.${DATASET_ID}.${TABLE_ID}\`
   WHERE marks > 60
   ORDER BY marks DESC
   LIMIT 10"
}

# ---- 5. Export Query Results to a New Table ----
save_query_as_table() {
  echo "Saving query results as a new table"
  bq query --use_legacy_sql=false \
    --destination_table=${PROJECT_ID}:${DATASET_ID}.top_performers \
    --replace \
    "SELECT * FROM \`${PROJECT_ID}.${DATASET_ID}.${TABLE_ID}\` WHERE marks > 75"
}

# ---- 6. Export Table Data back to GCS ----
export_table_to_gcs() {
  echo "Exporting table to GCS"
  bq extract \
    --destination_format=CSV \
    ${PROJECT_ID}:${DATASET_ID}.${TABLE_ID} \
    gs://${BUCKET_NAME}/exports/student_performance_export.csv
}

# ---- 7. List Datasets and Tables ----
list_resources() {
  echo "Listing datasets in project:"
  bq ls --project_id=$PROJECT_ID

  echo "Listing tables in dataset:"
  bq ls ${PROJECT_ID}:${DATASET_ID}
}

# ---- 8. Delete Table / Dataset (cleanup) ----
cleanup() {
  echo "Deleting table: $TABLE_ID"
  bq rm -f -t ${PROJECT_ID}:${DATASET_ID}.${TABLE_ID}

  echo "Deleting dataset: $DATASET_ID"
  bq rm -r -f -d ${PROJECT_ID}:${DATASET_ID}
}

# ---- Main Menu ----
echo "1) Create Dataset"
echo "2) Create Table"
echo "3) Load Data from GCS"
echo "4) Run Query"
echo "5) Save Query as Table"
echo "6) Export Table to GCS"
echo "7) List Datasets/Tables"
echo "8) Cleanup (delete table & dataset)"
read -p "Choose an option: " choice

case $choice in
  1) create_dataset ;;
  2) create_table ;;
  3) load_data_from_gcs ;;
  4) run_query ;;
  5) save_query_as_table ;;
  6) export_table_to_gcs ;;
  7) list_resources ;;
  8) cleanup ;;
  *) echo "Invalid option" ;;
esac
