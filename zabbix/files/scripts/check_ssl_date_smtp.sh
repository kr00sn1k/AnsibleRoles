#!/bin/bash

DOMAIN=$1
RETVAL=0
EXPIRE_DATE=`echo | openssl s_client -starttls smtp -connect $DOMAIN:25 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d'=' -f2`
EXPIRE_SECS=`date -d "${EXPIRE_DATE}" +%s`
EXPIRE_TIME=$(( ${EXPIRE_SECS} - `date +%s` ))

if test $EXPIRE_TIME -lt 0
then
	RETVAL=0
else
	RETVAL=$(( ${EXPIRE_TIME} / 24 / 3600 ))
fi

echo ${RETVAL}
