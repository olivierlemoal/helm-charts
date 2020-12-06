#!/bin/bash
export DUMP_FILE=/backup_`date +%Y%m%d_%H%M%S`.pgdump
PGPASSWORD=$POSTGRES_PASSWORD pg_dump -d $POSTGRES_DB -U $POSTGRES_USER -h $POSTGRES_HOST -f $DUMP_FILE
bzip2 $DUMP_FILE
mcrypt ${DUMP_FILE}.bz2 -k $DB_BACKUP_PASSWORD

s3cmd put ${DUMP_FILE}.bz2.nc s3://$S3_BACKUP_PATH/history/ --host $S3_ENDPOINT  --access_key $S3_ACCESS_KEY --secret_key $S3_SECRET_KEY --host-bucket $S3_ENDPOINT
s3cmd cp s3://$S3_BACKUP_PATH/history/${DUMP_FILE}.bz2.nc s3://$S3_BACKUP_PATH/backup_last.bz2.nc --host $S3_ENDPOINT  --access_key $S3_ACCESS_KEY --secret_key $S3_SECRET_KEY --host-bucket $S3_ENDPOINT
s3cmd setlifecycle /lifecycle.xml s3://$S3_BACKUP_PATH --host $S3_ENDPOINT  --access_key $S3_ACCESS_KEY --secret_key $S3_SECRET_KEY --host-bucket $S3_ENDPOINT
