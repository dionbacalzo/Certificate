#!/bin/bash

# sample cmd with path 
# ./ssl.sh "C:/Program Files/Apache Software Foundation/Tomcat 9.0/conf"
# ./ssl.sh "C:/Users/81015414/eclipse-workspace/Shop/SSL Setup" "certificate.p12"

keydirectory=$1

if [ -z "$1" ] 
then
    echo "1st argument not found will default to current directory"
fi

keyfile=$2

if [ -z "$2" ] 
then
  	keyfile=localhost.p12
    echo "2nd argument not found default filename will be $keyfile"
fi

certificate="$keyfile"
if [ ! -z "$keydirectory" ] 
then
	certificate=$keydirectory/$keyfile
fi

openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem -config ssl.conf -extensions v3_req &&
openssl pkcs12 -export -out "$certificate" -in cert.pem -inkey key.pem -passin pass:password -passout pass:password -name shopserver

echo "certificate found at $certificate"