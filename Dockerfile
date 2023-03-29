FROM us.gcr.io/broad-dsp-gcr-public/terra-jupyter-r:2.0.4
USER root

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

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

## R packages
RUN Rscript -e "BiocManager::install(c('AnVIL', 'jmonlong/sveval'))"

## odgi
# dependencies
RUN apt-get update \
    && apt-get install -y \
    git \
    bash \
    cmake \
    g++ \
    python3-dev \
    libatomic-ops-dev \
    autoconf \
    libgsl-dev \
    zlib1g-dev \
    libzstd-dev \
    libjemalloc-dev \
    libhts-dev \
    build-essential \
    pkg-config \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN git clone --recursive https://github.com/pangenome/odgi.git

WORKDIR /build/odgi
RUN cmake -H. -DCMAKE_BUILD_TYPE=Generic -Bbuild \
    && cmake --build build -- -j 1 \
    && cp bin/odgi /usr/local/bin/odgi \
    && rm -rf deps \
    && rm -rf .git \
    && rm -rf build \
    && apt-get clean \
    && apt-get purge  \
    && rm -rf /var/lib/apt/lists/* /tmp/*


WORKDIR /bin
RUN rm -f vg && \
    wget --no-check-certificate --quiet https://github.com/vgteam/vg/releases/download/v1.43.0/vg && \
    chmod +x vg

##
WORKDIR /home/jupyter
USER $USER
