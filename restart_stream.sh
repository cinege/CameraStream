#!/bin/bash


# The IP for the server you wish to ping (8.8.8.8 is a public Google DNS server)
SERVER=8.8.8.8
# Only send two pings, sending output to /dev/null
ping -c2 ${SERVER} > /dev/null
# If the return code from ping ($?) is not 0 (meaning there was an error)
if [ $? != 0 ]
then
  # Restart the  device
  echo $(date) "Network down... Restarting pi..." >> /home/pi/restartlog
  sudo reboot
else
  if pgrep ffmpeg
  then
    echo "Streaming..."
  else
    echo $(date) "Not streaming... restarting ffmpeg..." >> /home/pi/restartlog
    sh ./start_stream.sh
    sleep 10
    if ! pgrep ffmpeg
    then
      echo $(date) "Couldn't restart streaming. Restarting pi..." >> /home/pi/restartlog 
      sudo reboot
    fi
  fi
fi
