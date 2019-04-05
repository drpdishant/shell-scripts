#!/bin/sh

#find and delete any data older than a week.
echo "Removing Week old Data"
find . -type f -name "*.csv" -mtime +7 -exec rm {} \;

#Sync data with the remote server
echo "Syncing Data with Remote Server"
rysnc . <user>@<host>:<remote-file-path> --delete
