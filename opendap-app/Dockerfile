FROM opendap/hyrax:snapshot

RUN yum -y update && \
    yum -y upgrade

RUN yum install -y centos-release-scl && \
    yum install -y rh-python36

ENV PATH=/opt/rh/rh-python36/root/usr/bin:$PATH

RUN pip install supervisor

# Development
RUN yum -y install nano



COPY supervisord.conf /etc/supervisord.conf
COPY app.py /root/app.py
COPY requirements.txt /root/requirements.txt

RUN pip install -r /root/requirements.txt

COPY dmrpp.conf dmrpp.conf

RUN rm -r /usr/share/hyrax/data/* && \
    mkdir -p /usr/share/hyrax/data/ghrc_data && \
    touch /usr/share/hyrax/data/ghrc_data/example.tx
RUN  sed -i \
-e 's/NodeCache.*/NodeCache maxEntries="20000" refreshInterval="8"\/\>/g' \
/var/lib/tomcat/webapps/opendap/WEB-INF/conf/olfs.xml

COPY cron_workers.py /root/cron_workers.py
COPY sync_files.sh /root/sync_files.sh

EXPOSE 5000
# For debug
RUN pip install ipython
ENTRYPOINT []
#ENTRYPOINT [ "supervisord", "-c", "/etc/supervisord.conf" ]