#!/bin/bash

# Log file to store the script's output
LOGFILE="/var/log/start-jelly.log"

# Variables for mount point and CT ID
MOUNT_POINT="/mnt/pve/DriveName" #Your mount folder of SMB Share
CT_ID=101 #Change it to your container id

# Log the start time of the script
echo "Script started at $(date)" >> $LOGFILE

# Infinite loop to check for the mount point
while true; do
    # Check if the mount point is available
    if grep -qs "$MOUNT_POINT " /proc/mounts; then 
        echo "$(date): $MOUNT_POINT is mounted" >> $LOGFILE
        
        # Check if the CT is stopped
        if /usr/sbin/pct status $CT_ID | grep -q "status: stopped"; then # "/usr/sbin/pct status" is the same as "pct status" running in shell on the node
            echo "$(date): CT $CT_ID is stopped" >> $LOGFILE
            # Start the CT
            /usr/sbin/pct start $CT_ID
            echo "$(date): CT $CT_ID started" >> $LOGFILE
        else
            echo "$(date): CT $CT_ID is already running" >> $LOGFILE
        fi

        # Break the loop and exit the script
        break
    else
        # Log that the mount point is not found and wait before retrying
        echo "$(date): $MOUNT_POINT not mounted, waiting..." >> $LOGFILE
        sleep 5
    fi
done

# Log the end time of the script
echo "Script ended at $(date)" >> $LOGFILE
