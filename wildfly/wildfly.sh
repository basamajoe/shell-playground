#!/bin/sh
#JBOSS start and stop script.
#rks2286(at)gmail(dot)com
#Sample script start and stop for jboss:
#-----------------------
#Changable texts JBOSS_ROOT, ADMIN_USERNAME, ADMIN_PASSWD, ADMIN_PORT, RMI_PORT, PROFILE.
#-----------------------
JBOSS_ROOT=/opt/wildfly/wildfly-10.1.0.Final/
ADMIN_USERNAME=admin
ADMIN_PASSWD=jbossadm
ADMIN_PORT=8080
RMI_PORT=1099
PROFILE=all
#---------------------
#JBOSS StartUp.....
#---------------------
export CLASSPATH
start() {
  echo Starting jboss...;
  echo Wait while the jboss server starts...;
  $JBOSS_ROOT/bin/run.sh -c $PROFILE -b 0.0.0.0 > /tmp/null &
}
#-------------------
#JBOSS shutdown.....
#-------------------

stop() {
  echo Stopping jboss..;
  echo Wait while the jboss server stops;
  $JBOSS_ROOT/bin/shutdown.sh -s `hostname`:$RMI_PORT -u $ADMIN_USERNAME -p $ADMIN_PASSWD &
}
status() {
  echo Checking JBoss Status..
  echo Wait for a while...
  _up=`netstat -an | grep $ADMIN_PORT | grep -v grep | wc -l`

  if [[ "${_up}" != "0" ]]; then
    echo "###############################################"
    echo "JBoss Application Server is Up!! And Running.!!"
    echo "###############################################"
  else
    echo "##################################"
    echo "JBoss Application Server is Down!!"
    echo "##################################"
  fi;
}

if [[ "${1}" == "start" ]]; then
  start
elif [[ "${1}" == "stop" ]]; then
  stop
elif [[ "${1}" == "status" ]]; then
  status
else
  echo "####################################################"
  echo Usage:
  echo export JBOSS_ROOT=Path_To_Root_Folder
  echo .\/\jboss.sh start\|\stop;
  echo Example:
  echo export JBOSS_ROOT=\/\opt\/\jboss-eap-4.3\/\jboss-as;
  echo ./jboss.sh start\|\stop;
  echo "####################################################"
fi;
  exit 0;
