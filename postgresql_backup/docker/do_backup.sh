#!/bin/bash
export DUMP_FILE=backup_`date +%Y%m%d_%H%M%S`.pgdump
PGPASSWORD=$POSTGRES_PASSWORD pg_dump -d $POSTGRES_DB -U $POSTGRES_USER -h $POSTGRES_HOST -f $DUMP_FILE
zstd $DUMP_FILE
openssl enc -e -aes-256-cbc -pbkdf2 -nosalt -in ${DUMP_FILE}.zst -out ${DUMP_FILE}.zst.enc -pass pass:$DB_BACKUP_PASSWORD

s3cmd put ${DUMP_FILE}.zst.enc s3://$S3_BACKUP_PATH/history/ --host $S3_ENDPOINT  --access_key $S3_ACCESS_KEY --secret_key $S3_SECRET_KEY --host-bucket $S3_ENDPOINT
s3cmd cp s3://$S3_BACKUP_PATH/history/${DUMP_FILE}.zst.enc s3://$S3_BACKUP_PATH/backup_last.zst.enc --host $S3_ENDPOINT  --access_key $S3_ACCESS_KEY --secret_key $S3_SECRET_KEY --host-bucket $S3_ENDPOINT
s3cmd setlifecycle /lifecycle.xml s3://$S3_BACKUP_PATH --host $S3_ENDPOINT  --access_key $S3_ACCESS_KEY --secret_key $S3_SECRET_KEY --host-bucket $S3_ENDPOINT
