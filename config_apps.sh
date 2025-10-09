#!/bin/bash

# Define the list of apps to open (in order)
APPS_LIST=(
    "Bitwarden"
    "Google Chrome"
    "Alfred 5"
    "Rectangle"
    "Cursor"
    "Docker"
    "Postman"
    "Slack"
    "WhatsApp"
    "Hidden Bar"
)

# Function to display usage
usage() {
    echo "Usage: $0"
    echo "This script will open each app in order and wait for you to close it:"
    for i in "${!APPS_LIST[@]}"; do
        echo "  $((i+1)). Open ${APPS_LIST[i]} → Wait for you to close it"
    done
    echo ""
    echo "Process for each app:"
    echo "  1. Open the app"
    echo "  2. Wait for you to press Enter (or type 'yes') to proceed to the next app"
    echo "  3. Move to the next app"
    echo ""
    echo "Note: Type anything other than Enter or 'yes' to exit the script."
    echo ""
    echo "To modify the apps list, edit the APPS_LIST array in this script."
    exit 1
}

# Show help if requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage
fi

# Open each app in the list
for i in "${!APPS_LIST[@]}"; do
    APP_NAME="${APPS_LIST[i]}"
    echo "Opening $((i+1))/${#APPS_LIST[@]}: $APP_NAME"
    open -a "$APP_NAME"
    
    echo "You can now use $APP_NAME."
    echo "When you're ready to proceed to the next app, press Enter (or type 'yes'):"
    
    # Wait for user input
    read -r user_input
    # If user just presses Enter (empty input) or types 'yes', proceed
    if [ -z "$user_input" ] || [ "$user_input" = "yes" ]; then
        echo "Proceeding to the next app..."
    else
        echo "Exiting script..."
        exit 0
    fi
        
    # Add a small delay before opening the next app (except for the last one)
    if [ $i -lt $((${#APPS_LIST[@]} - 1)) ]; then
        sleep 1
    fi
done

echo "Done! All apps have been opened and closed."
