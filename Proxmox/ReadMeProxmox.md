# Proxmox and stuff


This is a Cron Job to force your container to start only after proxmox connects the SMB Share.
First we need to open the cron job editor.

## 1. Go to you node
pve in the left column for example and choose "Shell".
   
## 2. Download [`CronJobForWaitingSMBShare.sh`](Proxmox/CronJobForWaitingSMBShare.sh)
on your host machine or create a shell script with contents of it.
  - Don't forget where we put our script!
  - Don't forget to change the parameters inside the script to suit yourself! (check the comments inside the script file)
  - You can create file with nano or other text editors built in proxmox
  ```bash

  nano CronJobForWaitingSMBShare.sh
  ```
  - And save it with <kbd>Ctrl</kbd> + <kbd>O</kbd>
    
## 3. Open crontab editor
   
  ### If user root:
   
  ```bash

  crontab -e
  ```

### else:

  ```bash

  sudo crontab -e
  ```

## 4. Add a line after all of this commented lines
   
```bash

@reboot /home/CronJobForWaitingSMBShare.sh
```

Where is @reboot is time to start our script (you can edit the startup time to suit your needs by checking the crontab documentation). And /home/CronJobForWaitingSMBShare.sh is full way from root folder to our script file. 
## Logs

You can check the result of the script in the logs /var/log/start.log

