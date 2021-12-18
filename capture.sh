now=`date '+%Y_%m_%d__%H_%M'`;
wget http://192.168.100.7:8081/?action=snapshot -O /home/pi/kepek/$now.jpg
