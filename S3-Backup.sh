#!/bin/bash

S3_BUCKET="hetzner-storage"
LOG_FILE="/var/log/s3_upload.log"
AWS_PROFILE="default"

files_to_back=(
    "/home/callum"
    "/var/www/index"
)

TIMESTAMP=$(date "+%d-%m-%y_%H-%M")
BASE_UPLOAD_DIR="$TIMESTAMP"

upload_to_s3() {
    local item=$1
    local dir_name=$(basename "$item")

    if [[ -e "$item" ]]; then
        DEST_DIR="$BASE_UPLOAD_DIR/$dir_name"
        echo "[$(date '+%d-%m-%y %H:%M')] Uploading: $item to $DEST_DIR/" | tee -a "$LOG_FILE"
        aws s3 cp "$item" "s3://$S3_BUCKET/$DEST_DIR/" --recursive --profile "$AWS_PROFILE" >> "$LOG_FILE" 2>&1
        if [[ $? -eq 0 ]]; then
            echo "[$(date '+%d-%m-%y %H:%M')] SUCCESS: $item uploaded to $DEST_DIR/." | tee -a "$LOG_FILE"
        else
            echo "[$(date '+%d-%m-%y %H:%M')] ERROR: Failed to upload $item." | tee -a "$LOG_FILE"
        fi
    else
        echo "[$(date '+%d-%m-%y %H:%M')] WARNING: $item does not exist. Skipping." | tee -a "$LOG_FILE"
    fi
}

# Main script
echo "[$(date '+%d-%m-%y %H:%M')] Starting S3 upload process..." | tee -a "$LOG_FILE"

for item in "${files_to_back[@]}"; do
    upload_to_s3 "$item"
done

echo "[$(date '+%d-%m-%y %H:%M')] S3 upload process completed." | tee -a "$LOG_FILE"

exit 0