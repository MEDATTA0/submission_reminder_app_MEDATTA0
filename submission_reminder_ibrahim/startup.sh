#!/bin/bash

# Start the submission reminder app
echo "Starting the submission reminder application..."

# Source the configuration and functions
source ./config/config.env
source ./modules/functions.sh

# Display the assignment and days remaining
# echo "Assignment: "
# echo "Days Remaining: "

# Run the reminder script
bash ./app/reminder.sh

echo "Reminder application has been executed."

