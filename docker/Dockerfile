FROM alpine:edge
RUN apk update && \
    apk --no-cache add ca-certificates && \
    apk --no-cache add git g++ gcc clang make cmake git bash shadow gdb

ENV USER=devel USER_ID=1000 USER_GID=1000

RUN groupadd --gid "${USER_GID}" "${USER}" && \
    useradd \
        --uid ${USER_ID} \
        --gid ${USER_GID} \
        --create-home \
        --shell /bin/bash \
        ${USER}

COPY user-mapping.sh /usr/bin
RUN chmod u+x /usr/bin/user-mapping.sh

ENTRYPOINT ["/usr/bin/user-mapping.sh"]
MAINTAINER Marco Craveiro (marco.craveiro@gmail.com)
