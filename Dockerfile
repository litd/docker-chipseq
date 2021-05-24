# % Last Change: Mon May 24 11:55:08 AM 2021 CDT
# Base Image
FROM debian:10.9

# File Author / Maintainer
MAINTAINER Tiandao Li <litd99@gmail.com>

ENV PATH /opt/conda/bin:$PATH
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Installation
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    bc \
    bedtools \
    bwa \
    bzip2 \
    curl \
    cutadapt \
    fastqc \
    g++ \
    jq \
    libgsl-dev \
    macs \
    make \
    r-base \
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
    echo 'install.packages("ggplot2",repos="http://cran.us.r-project.org")' > /opt/packages.R && \
    echo 'install.packages("cowplot",repos="http://cran.us.r-project.org")' >> /opt/packages.R && \
    echo 'install.packages("jsonlite",repos="http://cran.us.r-project.org")' >> /opt/packages.R && \
    /usr/bin/Rscript /opt/packages.R && \
    rm /opt/packages.R && \
    mkdir -p /usr/local/lib/R/site-library && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/dpkg.log /var/tmp/*

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	echo "America/Chicago" > /etc/timezone

CMD [ "/bin/bash" ]

