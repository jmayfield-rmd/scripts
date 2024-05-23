#!/bin/bash

# Function to print usage
usage() {
  echo "Usage: $0 {upload|download} <local-path> <s3-bucket-path>"
  echo "  upload   - Copy a file from local to S3"
  echo "  download - Copy a file from S3 to local"
  exit 1
}

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
  usage
fi

# Assign arguments to variables
COMMAND=$1
LOCAL_PATH=$2
S3_PATH=$3

# Function to upload a file to S3
upload_to_s3() {
  rclone copy "$LOCAL_PATH" "$S3_PATH"
  if [ $? -eq 0 ]; then
    echo "File successfully uploaded to $S3_PATH"
  else
    echo "Failed to upload file to $S3_PATH"
    exit 1
  fi
}

# Function to download a file from S3
download_from_s3() {
  rclone copy "$S3_PATH" "$LOCAL_PATH"
  if [ $? -eq 0 ]; then
    echo "File successfully downloaded to $LOCAL_PATH"
  else
    echo "Failed to download file to $LOCAL_PATH"
    exit 1
  fi
}

# Execute the appropriate command
case $COMMAND in
  upload)
    upload_to_s3
    ;;
  download)
    download_from_s3
    ;;
  *)
    usage
    ;;
esac

