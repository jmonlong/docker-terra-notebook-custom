FROM us.gcr.io/broad-dsp-gcr-public/terra-jupyter-r:2.0.4
USER root

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -yq --no-install-recommends \
        less \
        bcftools \
        samtools \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

## vg
WORKDIR /bin
RUN wget --no-check-certificate --quiet https://github.com/vgteam/vg/releases/download/v1.37.0/vg && \
        chmod +x vg

ENV PATH $PATH:/bin

## GNU time
WORKDIR /build
RUN wget https://ftp.gnu.org/gnu/time/time-1.9.tar.gz && \
        tar -xzvf time-1.9.tar.gz && \
        cd time-1.9 && \
        ./configure && \
        make && \
        make install

WORKDIR /home/jupyter
USER $USER
