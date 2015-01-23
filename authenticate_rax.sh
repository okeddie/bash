#!/bin/bash
resize; clear; echo `date`; echo "Hello, please enter a username: "; read user ; echo "Enter your auth key please: "; read authkey ;echo "Your Token is: "; curl -H"X-Auth-User: $user" -H"X-Auth-Key: $authkey" https://auth.api.rackspacecloud.com/v1.0 -D - 2>&1 |awk '/Auth-Token:/{print $2}';
