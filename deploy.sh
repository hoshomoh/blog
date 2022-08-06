#!/bin/bash

# Create a temporary directory and store its name in a variable.
TEMP_DIR=$(mktemp -d)
NOW=$(date +"%D %T")
COMMIT_MSG="Site updated at $NOW"

# Exit if the temp directory wasn't created successfully.
if [ ! -e "$TEMP_DIR" ]; then
    >&2 echo "Failed to create temp directory"
    exit 1
fi

# Move generated site to temporary directory
mv _site/* $TEMP_DIR
git checkout -B master
git pull origin master
rm -rf *
mv $TEMP_DIR/* .

# Push changes to github
git add .
git commit -am "${COMMIT_MSG}"
git push origin master --force
git checkout dev

# Exit on done
echo "Deployment Done"
rm -rf $TEMP_DIR
