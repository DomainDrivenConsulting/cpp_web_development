#!/bin/bash

# Losely based on https://gist.github.com/renzok/29c9e5744f1dffa392cf
#
# Ensure you set the environment:
#
#    USER_NAME=$(whoami) USER_ID=$(id -u) GROUP_ID=$(id -g)
#
# If you want to edit code from your existing home directory, ensure
# you bind mount home:
#
#     -v /home/$(whoami):/home/$(whoami)
#

if [ -z "${USER_NAME}" ]; then
    echo "We need USER_NAME to be set!";
    exit 1;
fi

if [ -z "${USER_ID}" ]; then
    echo "We need USER_ID to be set!";
    exit 1;
fi

if [ -z "${GROUP_ID}" ]; then
    echo "We need GROUP_ID to be set!";
    exit 1;
fi

groupadd --gid "${GROUP_ID}" "${USER_NAME}"
useradd --uid ${USER_ID} --gid ${GROUP_ID} --shell /bin/bash ${USER_NAME}

exec su - "${USER_NAME}"
