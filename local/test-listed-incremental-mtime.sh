#!/bin/bash
set -o nounset -o errexit -o pipefail -o noglob

testdir="local/test-listed-incremental-mtime-$(date +%s).testdir"
mkdir "${testdir}"
echo "testdir: ${testdir}"

cp src/tar "${testdir}/tar"
cd "${testdir}"

echo
echo '1:'
mkdir data
touch data/a
./tar \
    --create \
    --verbose \
    --file=1.tar \
    --listed-incremental=1.snar \
    data \
| tee '1.log'
if ! grep -q '^data/a$' '1.log'; then
    echo >&2 'error: data/a not in 1.log.'
else
    echo 1: OK
fi

sleep 1

echo
echo '2:'
mv data/a data/b
cp '1.snar' '2.snar'
./tar \
    --create \
    --verbose \
    --file=2.tar \
    --listed-incremental=2.snar \
    data \
| tee '2.log'
if ! grep -q '^data/b$' '2.log'; then
    echo >&2 'error: data/b not in 2.log.'
else
    echo '2: OK'
fi

sleep 1

echo
echo '3:'
touch -a data/b
cp '2.snar' '3.snar'
./tar \
    --create \
    --verbose \
    --file=3.tar \
    --listed-incremental=3.snar \
    data \
| tee '3.log'
if ! grep -q '^data/b$' '3.log'; then
    echo >&2 'error: data/b not in in 3.log.'
else
    echo '3a: OK'
fi
echo '3b:'
cp '2.snar' '3b.snar'
./tar \
    --create \
    --verbose \
    --file=3b.tar \
    --listed-incremental-mtime=3b.snar \
    data \
| tee '3b.log'
if grep -q '^data/b$' '3b.log'; then
    echo >&2 'error: unexpected data/b in 3.log.'
else
    echo '3b: OK'
fi
echo '3: OK'

echo
echo "testdir: ${testdir}"
