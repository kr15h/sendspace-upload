#!/bin/bash

# Specify file to upload here.
FILE="./cat.png"

# SendSpace API key
# https://www.sendspace.com/dev_apikeys.html
API_KEY="your-key-here"

echo "Uploading $(basename ${FILE})..."

# Get info from SendSpace before uploading.
RESPONSE=$(curl "http://api.sendspace.com/rest/?method=anonymous.uploadGetInfo&api_key=${API_KEY}&api_version=1.2" | grep "<upload")

UP_URL=$(echo "${RESPONSE}" | sed -E "s/.* url=\"(.*)\" m.*/\1/")
#echo "${UP_URL}"

UP_MAX=$(echo "${RESPONSE}" | sed -E "s/.* max_file_size=\"(.*)\" u.*/\1/")
#echo "${UP_MAX}"

UP_ID=$(echo "${RESPONSE}" | sed -E "s/.* upload_identifier=\"(.*)\" e.*/\1/")
#echo "${UP_ID}"

UP_EXTRA=$(echo "${RESPONSE}" | sed -E "s/.* extra_info=\"(.*)\".*/\1/")
#echo "${UP_EXTRA}"

# Do the actual upload.
RESPONSE=$(curl -X "POST" -F "MAX_FILE_SIZE=${UP_MAX}" -F "UPLOAD_IDENTIFIER=${UP_ID}" -F "extra_info=${UP_EXTRA}" -F "userfile=@${FILE}" "${UP_URL}")
STATUS=$(echo "${RESPONSE}" | grep "<status>" | sed -E "s/.*<status>([a-z][a-z]*)<\/status>.*/\1/")

if [ "${STATUS}" = "ok" ]; then
    echo "Upload successful."
else
    echo "Upload failed."
fi

DL_URL=$(echo "${RESPONSE}" | grep "<download_url>" | sed -E "s/.*<download_url>(.*)<\/download_url>.*/\1/")
echo "Dowload URL: ${DL_URL}"

RM_URL=$(echo "${RESPONSE}" | grep "<delete_url>" | sed -E "s/.*<delete_url>(.*)<\/delete_url>.*/\1/")
echo "Delete URL: ${RM_URL}"



