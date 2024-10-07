#!/bin/bash

# Configuration
APP_NAME="myapp"
APP_WAR="/path/to/myapp.war"
TOMCAT_DIR="/opt/tomcat"
BACKUP_DIR="/opt/tomcat/backup"
LOG_DIR="/opt/tomcat/logs"
TOMCAT_USER="tomcat"
SERVER_IP="192.168.1.100"
REMOTE_USER="your_ssh_user"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root${NC}"
    exit 1
fi

# Stop Tomcat
echo -e "${GREEN}Stopping Tomcat server...${NC}"
systemctl stop tomcat
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to stop Tomcat.${NC}"
    exit 1
fi

# Backup the current .war and logs
echo -e "${GREEN}Backing up existing .war and logs...${NC}"
mkdir -p $BACKUP_DIR/$(date +%F-%T)
cp $TOMCAT_DIR/webapps/$APP_NAME.war $BACKUP_DIR/$(date +%F-%T)/$APP_NAME.war
cp -r $LOG_DIR $BACKUP_DIR/$(date +%F-%T)/logs

# Upload the new .war file
echo -e "${GREEN}Uploading new .war file...${NC}"
scp $APP_WAR $REMOTE_USER@$SERVER_IP:$TOMCAT_DIR/webapps/
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to upload the .war file.${NC}"
    exit 1
fi

# Clean old files
echo -e "${GREEN}Cleaning old deployment files...${NC}"
rm -rf $TOMCAT_DIR/webapps/$APP_NAME
rm -rf $TOMCAT_DIR/webapps/$APP_NAME.war

# Move the new .war to the deployment directory
echo -e "${GREEN}Moving new .war to the deployment directory...${NC}"
mv /path/to/new/$APP_NAME.war $TOMCAT_DIR/webapps/

# Set correct permissions
echo -e "${GREEN}Setting correct permissions...${NC}"
chown -R $TOMCAT_USER:$TOMCAT_USER $TOMCAT_DIR/webapps/$APP_NAME.war

# Start Tomcat
echo -e "${GREEN}Starting Tomcat server...${NC}"
systemctl start tomcat
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to start Tomcat.${NC}"
    exit 1
fi

# Check if Tomcat started correctly
sleep 5
echo -e "${GREEN}Checking if the application is up...${NC}"
curl -Is http://localhost:8080/$APP_NAME | head -n 1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Deployment successful.${NC}"
else
    echo -e "${RED}Application is not running.${NC}"
    exit 1
fi

C

C

