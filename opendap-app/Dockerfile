FROM opendap/hyrax:snapshot

RUN yum -y update && \
    yum -y upgrade

RUN yum install -y centos-release-scl && \
    yum install -y rh-python36

ENV PATH=/opt/rh/rh-python36/root/usr/bin:$PATH

RUN pip install supervisor

# Development
RUN yum -y install nano


COPY entry_point.sh /root/entry_point.sh
COPY supervisord.conf /etc/supervisord.conf
COPY app.py /root/app.py
COPY requirements.txt /root/requirements.txt

RUN pip install -r /root/requirements.txt

COPY dmrpp.conf dmrpp.conf

EXPOSE 5000

ENTRYPOINT []
#ENTRYPOINT [ "supervisord", "-c", "/etc/supervisord.conf" ]