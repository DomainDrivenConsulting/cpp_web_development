FROM alpine:edge
MAINTAINER Marco Craveiro (marco.craveiro@gmail.com)

#
# Install the base packages such as compilers, etc.
#
RUN apk update && \
    apk --no-cache add ca-certificates && \
    apk --no-cache add shadow musl-dev bash \
                       clang cmake make git g++ gcc gdb ninja tar wget linux-headers \
                       libxml2-dev llvm-dev clang-dev gmp-dev postgresql-dev

arg cmake_build_type=MinSizeRel

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
    ./b2 variant=release link=static,shared threading=multi install && \
    cd /home && \
    rm -rf boost_${boost_us_version}

#
# Build and install wt from master. We can't use the released version
# because there is a bug at present that is fixed only in master. See;
#
#     https://redmine.emweb.be/issues/6199#change-19540
#
ARG wt_hash=da3f9de92df90030990e211577e151ea44c3c265
RUN cd /home && \
    wget https://github.com/emweb/wt/archive/${wt_hash}.zip && \
    unzip ${wt_hash}.zip && \
    cd wt-${wt_hash} && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf wt-${wt_hash} ${wt_hash}.zip

#
# Bild and install rtags from master. We always want latest rtags
# becasue there are always lots of fixes.
#
ARG rtags_hash=3584c326a93a994cd329cd7d15d627d9375b678b
ARG rct_hash=b3e6f41d9844ef64420e628e0c65ed98278a843a
RUN cd /home && \
    wget https://github.com/Andersbakken/rtags/archive/${rtags_hash}.zip && \
    unzip ${rtags_hash}.zip && \
    cd rtags-${rtags_hash}/src && \
    wget https://github.com/Andersbakken/rct/archive/${rct_hash}.zip && \
    unzip ${rct_hash}.zip && \
    mv rct-${rct_hash}/* rct && \
    cd .. && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf rtags-${rtags_hash} ${rtags_hash}.zip ${rct_hash}.zip

#
# Build and install ODB
#
ARG cutl_dot_partial_version=1.10
ARG cutl_dot_version=${cutl_dot_partial_version}.0
ARG odb_dot_partial_version=2.4
ARG odb_dot_version=${odb_dot_partial_version}.0
RUN cd /home && \
    wget https://www.codesynthesis.com/download/libcutl/${cutl_dot_partial_version}/libcutl-${cutl_dot_version}.tar.gz && \
    tar xaf libcutl-${cutl_dot_version}.tar.gz && \
    cd libcutl-${cutl_dot_version} && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf libcutl-${cutl_dot_version} libcutl-${cutl_dot_version}.tar.gz && \
    wget https://www.codesynthesis.com/download/odb/${odb_dot_partial_version}/libodb-${odb_dot_version}.tar.bz2 && \
    tar xaf libodb-${odb_dot_version}.tar.bz2 && \
    cd libodb-${odb_dot_version} && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    make install && \
    cd /home && \
    rm -rf libodb-${odb_dot_version} libodb-${odb_dot_version}.tar.bz2 && \
    wget https://www.codesynthesis.com/download/odb/${odb_dot_partial_version}/libodb-pgsql-${odb_dot_version}.tar.bz2 && \
    tar xaf libodb-pgsql-${odb_dot_version}.tar.bz2 && \
    cd libodb-pgsql-${odb_dot_version} && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf libodb-pgsql-${odb_dot_version} libodb-pgsql-${odb_dot_version}.tar.bz2

#
# Build and install Crypto++
#
ARG cryptopp_hash=c621ce053298fafc1e59191079c33acd76045c26
RUN cd /home && \
    wget https://github.com/weidai11/cryptopp/archive/${cryptopp_hash}.zip && \
    unzip ${cryptopp_hash}.zip && \
    cd cryptopp-${cryptopp_hash} && \
    make -j3 static dynamic && \
    make install PREFIX=/usr && \
    cd /home && \
    rm -rf cryptopp-${cryptopp_hash} ${cryptopp_hash}.zip

#
# Build and install Ranges
#
ARG ranges_hash=4ade4af033cf27f46504dc462b27daa3b425eb00
RUN cd /home && \
    wget https://github.com/ericniebler/range-v3/archive/${ranges_hash}.zip && \
    unzip ${ranges_hash}.zip && \
    cd range-v3-${ranges_hash} && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf range-v3-${ranges_hash} ${ranges_hash}.zip

#
# Build and install QuantLib
#
# Copying the config (last step) is a hack, as explained in this
# ticket:
#
# https://github.com/lballabio/QuantLib/issues/396
#
ARG quantlib_hash=a00d43fabf30ab1e7fcaeaa9f497a551b0de528c
RUN cd /home && \
    wget https://github.com/lballabio/QuantLib/archive/${quantlib_hash}.zip && \
    unzip ${quantlib_hash}.zip && \
    cd QuantLib-${quantlib_hash} && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf QuantLib-${quantlib_hash} ${quantlib_hash}.zip && \
    cp /usr/include/ql/config.ansi.hpp /usr/include/ql/config.hpp

#
# Build and install RapidXML
#
ARG rapidxml_hash=3ade9030f73b03bd648383da0ea0402b92da4e97
RUN cd /home && \
    wget https://github.com/timniederhausen/rapidxml/archive/${rapidxml_hash}.zip && \
    unzip ${rapidxml_hash}.zip && \
    cd rapidxml-${rapidxml_hash} && \
    mkdir /usr/include/rapidxml && \
    cp rapidxml.hpp rapidxml_iterators.hpp rapidxml_print.hpp rapidxml_utils.hpp /usr/include/rapidxml/ && \
    cd /home && \
    rm -rf rapidxml-${rapidxml_hash} ${rapidxml_hash}.zip

#
# Build and install RapidJSON
#
# NOTE: regular build borked at present, so disabling tests etc. See:
#
#     https://github.com/Tencent/rapidjson/issues/1164
#
ARG rapidjson_hash=fc7cda78a9b25e986f245ed0655df0aa4b71bc3b
RUN cd /home && \
    wget https://github.com/Tencent/rapidjson/archive/${rapidjson_hash}.zip && \
    unzip ${rapidjson_hash}.zip && \
    cd rapidjson-${rapidjson_hash} && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=/usr \
          -DRAPIDJSON_BUILD_DOC=off -DRAPIDJSON_BUILD_EXAMPLES=off \
          -DRAPIDJSON_BUILD_TESTS=off -DRAPIDJSON_BUILD_THIRDPARTY_GTEST=off .. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf rapidjson-${rapidjson_hash} ${rapidjson_hash}.zip

#
# Build and install OpenSourceRiskEngine
#
RUN apk --no-cache add autoconf automake libtool
ARG osre_hash=2a56688ff4d91e378bf88620a45864824150fbc5
RUN cd /home && \
    wget https://github.com/OpenSourceRisk/Engine/archive/${osre_hash}.zip && \
    unzip ${osre_hash}.zip && \
    cd Engine-${osre_hash} && \
    cd QuantExt && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    cd qle && \
    make -j3 && \
    make install && \
    cd ../../OREData && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    cd ored && \
    make -j3 && \
    make install && \
    cd ../../OREAnalytics && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    cd orea && \
    make -j3 && \
    make install && \
    cd ../../App && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf Engine-${osre_hash} ${osre_hash}.zip

#
# Build and install latest release of Dogen. Must be the last layer
# since we update it very frequently.
#
ARG dogen_dot_version=1.0.07
RUN cd /home && \
    wget https://github.com/DomainDrivenConsulting/dogen/archive/v${dogen_dot_version}.tar.gz && \
    tar xfz v${dogen_dot_version}.tar.gz && \
    cd dogen-${dogen_dot_version}/build && \
    mkdir output && \
    cd output && \
    cmake -DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=/usr ../.. && \
    make -j3 && \
    make install && \
    cd /home && \
    rm -rf dogen-1.0.07 v1.0.07.tar.gz

#
# Add sudo
#
RUN apk --no-cache add sudo

COPY user-mapping.sh /usr/bin
RUN chmod u+x /usr/bin/user-mapping.sh

ENTRYPOINT ["/usr/bin/user-mapping.sh"]
