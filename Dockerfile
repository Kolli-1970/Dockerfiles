FROM centos:7

ARG GIT_TAG=latest


RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    yum install ncurses-devel ncurses \
      git make cmake gcc gcc-c++ autoconf automake bc bison flex libtool patch devtoolset-7 \
        atlas-devel \
        blas \
        blas-devel \
        boost \
        boost-devel \
        bzip2-devel \
        check \
        check-devel \
        doxygen \
        elfutils-libelf-devel \
        gflags-devel \
        glog-devel \
        gmp-devel \
        gnutls-devel \
        guile-devel \
        kernel-devel \
        kernel-headers \
        lapack \
        lapack-devel \
        libasan \
        libconfig-devel \
        libevent-devel \
        libffi-devel \
        libgcrypt-devel \
        libidn-devel \
        libidn2-devel  \
        libtool \
        libusb-devel \
        libusb1-devel \
        libusbx-devel \
        libxml2-devel \
        libXpm-devel \
        libxslt-devel \
        libyaml-devel \
        lksctp-tools \
        lksctp-tools-devel \
        lz4-devel \
        mariadb-devel \
        nettle-devel \
        openssh-clients \
        openssh-server \
        openssl \
        openssl-devel \
        pkgconfig \
        psmisc \
        python-pip \
        python-mako \
        python2 \
        python-docutils \
        python2-docutils \
        python2-requests \
        unzip \
        vim-common \
        xforms-devel \
        xz-devel \
        zlib-devel \
RUN yum clean all && rm -rf /var/cache/yum 

RUN set -xe; \
    cd /usr/local/src; \
    git clone https://github.com/Kolli-1970/uhd.git;
WORKDIR /usr/local/src/uhd/
RUN git checkout UHD-3.13; \
    cd host; \
    mkdir build; \
    cd build; \
    cmake ../; \
    make; \
    make install; \
    ldconfig; \
    echo "export LD_LIBRARY_PATH=/usr/local/lib64" >> ~/.bashrc;
RUN cd /usr/local/lib64/uhd/utils; \
    uhd_images_downloader;
WORKDIR /usr/local/src/uhd/host/build/examples
RUN echo $PWD
CMD ["./rx_ascii_art_dft","--freq","3.64e9","--rate","122.88e6","--gain","20","--bw","80e6","--ref-lvl","-30"]
