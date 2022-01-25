#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=SprintBootFirst

echo "> Copy build file"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> Check current application's pid"

CURRENT_PID=$(pgrep -fl $PROJECT_NAME | grep jar | awk '{print $1}')

echo "> Current application's pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
        echo "> Do not kill process because it is not running now."
else
        echo "> kill -15 $CURRENT_PID"
        kill -15 "$CURRENT_PID"
        sleep 5
fi

echo "> Deploy new application"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> Add permission to $JAR_NAME"

chmod +x "$JAR_NAME"

echo "> Execute $JAR_NAME"

nohup java -jar \
       -Dspring.config.location=classpath:/application.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties,classpath:/application-real.properties \
       -Dspring.profiles.active=real \
       "$JAR_NAME" > "$REPOSITORY/nohup.out" 2>&1 &