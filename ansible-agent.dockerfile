FROM ubuntu:18.04
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

RUN     pip install --upgrade pip

RUN     pip3 install \
        setuptools \
        setuptools_rust \
        wheel \
        lxml
        
RUN     pip3 install ansible==${VERSION} \
        GitPython \
        atlassian-python-api \
        jinja2 \
        natsort \
        python-jenkins \
        python-nomad

RUN     ansible-galaxy collection install community.general


ENTRYPOINT []
CMD tail -f /dev/null
