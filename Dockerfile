# % Last Change: Sun May 23 11:17:14 PM 2021 CDT
# Base Image
#FROM continuumio/miniconda3:4.9.2
FROM debian:10.9

# File Author / Maintainer
MAINTAINER Tiandao Li <litd99@gmail.com>

ENV PATH /opt/conda/bin:$PATH

# Installation
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    bwa \
    bzip2 \
    curl \
    cutadapt \
    fastqc \
    g++ \
    libgsl-dev \
    macs \
    make \
    samtools \
    sra-toolkit \
    unzip \
    zlib1g-dev && \
    curl -fsSL https://github.com/smithlabcode/preseq/releases/download/v2.0.3/preseq_v2.0.3.tar.bz2 -o /opt/preseq_linux_v2.0.3.tar.bz2 && \
    tar xvjf /opt/preseq_linux_v2.0.3.tar.bz2 -C /opt/ && \
    rm /opt/preseq_linux_v2.0.3.tar.bz2 && \
    cd /opt/preseq/ && \
    make && \
    curl -fsSL http://regmedsrv1.wustl.edu/Public_SPACE/litd/Public_html/pkg/methylQA -o /usr/bin/methylQA && \
    chmod +x /usr/bin/methylQA && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/dpkg.log /var/tmp/*

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	echo "America/Chicago" > /etc/timezone

CMD [ "/bin/bash" ]

