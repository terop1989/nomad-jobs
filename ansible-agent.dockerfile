FROM ubuntu:focal
#
ARG VERSION=2.9.13
#
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        python3-pip \
        openssh-client \
        sshpass \
        git \
        && rm -rf /var/lib/apt/lists/*
# For Ansible
RUN pip3 install \
        setuptools \
        wheel \
        lxml
RUN pip3 install ansible==${VERSION}
# For Changelog
RUN pip3 install \
        GitPython \
        atlassian-python-api \
        jinja2 \
        natsort \
        python-jenkins

RUN mkdir /.ansible \
    && chmod 777 /.ansible


#
##
ENTRYPOINT []
CMD tail -f /dev/null
