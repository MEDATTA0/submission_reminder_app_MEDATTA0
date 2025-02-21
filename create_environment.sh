#!/bin/bash

# Ask for the user's name
echo -n "Enter your name: "
read userName

# Base directory name
dirName="submission_reminder_${userName}"

read -p "Please enter the name of the directory where the files are: " target_directory
read -p "Do you want to remove $directory_name after the operation? [Y/N]" delete_directory

#Check if the directory where the files are exists
if [[ $(find -name "$target_directory") == "" ]]; then
	echo "Sorry, the directory ${target_directory} doesn't exist."
	exit 1
fi

# Create the base directory
if [[ $(find -name "$dirName") == "" ]]; then
	mkdir "$dirName"
else
	rm -r "$dirName"
	mkdir "$dirName"
fi

# Create the subdirectories
mkdir "${dirName}/app"
mkdir "${dirName}/modules"
mkdir "${dirName}/assets"
mkdir "${dirName}/config"

ls 
ls ${dirName}
# Create files and populate them
# Config file
cat <<EOL > "${dirName}/config/config.env"
$(cat "${target_directory}/config.env")
EOL

# Functions file
cat "${target_directory}/functions.sh" > "${dirName}/modules/functions.sh"

# Reminder file
cat <<EOL > "${dirName}/app/reminder.sh"
$(cat "${target_directory}/reminder.sh")
EOL

# Submissions file
cat "${target_directory}/submissions.txt" > "${dirName}/assets/submissions.txt"
echo -e "# Submissions\nJohn Doe,Submitted\nJane Smith,Pending\nAlice Johnson,Submitted\nBob Brown,Pending\nCharlie White,Submitted" >> "$dirName/assets/submissions.txt"

# Startup script
echo -e "#!/bin/bash

# Start the submission reminder app
echo \"Starting the submission reminder application...\"

# Source the configuration and functions
source ./config.env
source ./functions.sh

# Display the assignment and days remaining
echo \"Assignment: $ASSIGNMENT\"
echo \"Days Remaining: $DAYS_REMAINING\"

# Run the reminder script
bash ./reminder.sh

echo \"Reminder application has been executed.\"
" > "$dirName/startup.sh"

# Make it executable
chmod +x "$dirName/startup.sh"

echo -e "Copying files:\t done"

if [[ "$delete_directory" == "Y" || "$delete_directory" == "y" ]]; then
	rm -r "$target_directory"
	echo "$target_directory removed successfully"
fi

# Success message
echo "Environment created successfully in $dirName."
