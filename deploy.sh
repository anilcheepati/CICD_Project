#!/bin/bash

# Variables
SERVER_USER="azureuser1"
SERVER_IP="20.115.42.216"
APP_NAME="MavenCICD"  # Adjusted app name based on your JAR file name

JAR_FILE="../target/MavenCICD-0.0.1-SNAPSHOT.jar"  # Adjusted path based on your directory structure
REMOTE_DIR="/home/$SERVER_USER/$APP_NAME"
BACKUP_DIR="$REMOTE_DIR/backup"

# Create remote directories if they don't exist
ssh $SERVER_USER@$SERVER_IP "mkdir -p $REMOTE_DIR && mkdir -p $BACKUP_DIR"

# Backup existing jar file
ssh $SERVER_USER@$SERVER_IP "if [ -f $REMOTE_DIR/$APP_NAME.jar ]; then mv $REMOTE_DIR/$APP_NAME.jar $BACKUP_DIR/$APP_NAME-\$(date +%F-%T).jar; fi"

# Copy the new jar file to the remote server
scp $JAR_FILE $SERVER_USER@$SERVER_IP:$REMOTE_DIR/$APP_NAME.jar

# Stop the existing application (if running)
ssh $SERVER_USER@$SERVER_IP "pkill -f 'java -jar $REMOTE_DIR/$APP_NAME.jar' || true"

# Start the new application
ssh $SERVER_USER@$SERVER_IP "nohup java -jar $REMOTE_DIR/$APP_NAME.jar > $REMOTE_DIR/$APP_NAME.log 2>&1 &"
