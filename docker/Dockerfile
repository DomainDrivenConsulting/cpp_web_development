FROM alpine:edge

#
# Install the base packages such as compilers, etc.
#
RUN apk update && \
    apk --no-cache add ca-certificates && \
    apk --no-cache add shadow musl-dev bash \
                       clang cmake make git g++ gcc gdb ninja tar wget linux-headers \
                       libxml2-dev llvm-dev clang-dev gmp-dev postgresql-dev

#
# Build and install boost
#
ARG boost_dot_version=1.66.0
ARG boost_us_version=1_66_0
RUN cd /home && \
    wget https://dl.bintray.com/boostorg/release/${boost_dot_version}/source/boost_${boost_us_version}.tar.gz && \
    tar xfz boost_${boost_us_version}.tar.gz && \
    rm boost_${boost_us_version}.tar.gz && \
    cd boost_${boost_us_version} && \
    ./bootstrap.sh --prefix=/usr && \
    ./b2 install && \
    cd /home && \
    rm -rf boost_${boost_us_version}

#
# Build and install latest release of Dogen.
#
ARG dogen_dot_version=1.0.07
RUN cd /home && \
    wget https://github.com/DomainDrivenConsulting/dogen/archive/v${dogen_dot_version}.tar.gz && \
    tar xfz v${dogen_dot_version}.tar.gz && \
    cd dogen-${dogen_dot_version}/build && \
    mkdir output && \
    cd output && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr ../.. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf dogen

#
# Build and install wt from master. We can't use the released version
# because there is a bug at present that is fixed only in master. See;
#
#     https://redmine.emweb.be/issues/6199#change-19540
#
RUN cd /home && \
    wget https://github.com/emweb/wt/archive/da3f9de92df90030990e211577e151ea44c3c265.zip && \
    unzip da3f9de92df90030990e211577e151ea44c3c265.zip && \
    cd wt-da3f9de92df90030990e211577e151ea44c3c265 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf wt-da3f9de92df90030990e211577e151ea44c3c265

#
# Bild and install rtags from master. We always want latest rtags
# becasue there are always lots of fixes.
#
RUN cd /home && \
    wget https://github.com/Andersbakken/rtags/archive/3584c326a93a994cd329cd7d15d627d9375b678b.zip && \
    unzip 3584c326a93a994cd329cd7d15d627d9375b678b.zip && \
    cd rtags-3584c326a93a994cd329cd7d15d627d9375b678b/src && \
    wget https://github.com/Andersbakken/rct/archive/b3e6f41d9844ef64420e628e0c65ed98278a843a.zip && \
    unzip b3e6f41d9844ef64420e628e0c65ed98278a843a.zip && \
    mv rct-b3e6f41d9844ef64420e628e0c65ed98278a843a/* rct && \
    cd .. && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf rtags-3584c326a93a994cd329cd7d15d627d9375b678b

#
# Build and install ODB
#
RUN cd /home && \
    wget https://www.codesynthesis.com/download/libcutl/1.10/libcutl-1.10.0.tar.gz && \
    tar xaf libcutl-1.10.0.tar.gz && \
    cd libcutl-1.10.0 && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf libcutl-1.10.0 && \
    wget https://www.codesynthesis.com/download/odb/2.4/libodb-2.4.0.tar.bz2 && \
    tar xaf libodb-2.4.0.tar.bz2 && \
    cd libodb-2.4.0 && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf libodb-2.4.0 && \
    wget https://www.codesynthesis.com/download/odb/2.4/libodb-pgsql-2.4.0.tar.bz2 && \
    tar xaf libodb-pgsql-2.4.0.tar.bz2 && \
    cd libodb-pgsql-2.4.0 && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf libodb-pgsql-2.4.0

COPY user-mapping.sh /usr/bin
RUN chmod u+x /usr/bin/user-mapping.sh

ENTRYPOINT ["/usr/bin/user-mapping.sh"]
MAINTAINER Marco Craveiro (marco.craveiro@gmail.com)
