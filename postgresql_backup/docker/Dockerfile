FROM bitnami/minideb:latest
RUN install_packages python3-minimal python3-pip bzip2 openssl postgresql-client wget
RUN wget "https://github.com/s3tools/s3cmd/releases/download/v2.1.0/s3cmd-2.1.0-py2.py3-none-any.whl" 
RUN pip3 install s3cmd-2.1.0-py2.py3-none-any.whl
COPY do_backup.sh /
RUN chmod +x /do_backup.sh
