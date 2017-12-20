#!/usr/bin/env bash

set -eu

cd /usr/local/src

FILE=$(node "${1}")

curl --upload-file "/tmp/${FILE}" "https://transfer.sh/${FILE}" && echo
