% README LOCAL -- DO NOT PUSH

Bootstrap on macOS:

```
brew install \
    autoconf \
    automake \
    gettext \
    m4 \
    texinfo \
    ;

PATH=/usr/local/Cellar/gettext/0.19.8.1/bin:$PATH ./bootstrap
./configure

make

./src/tar --version
```

With documentation:

```
make all html
open doc/tar.html/Introduction.html
```

Run tests:

```
make check
```

Docker build:

```
docker run -it --rm buildpack-deps:bionic

apt-get update
apt-get install -y \
    autopoint \
    bison \
    gettext \
    rsync \
    texinfo \
    ;

cd /tmp
git clone https://github.com/sprohaska/gnu-tar.git
cd gnu-tar
version=5d82c6ca76c6afb9852c4cda6acf954a524c30ed
git checkout ${version}
./bootstrap
FORCE_UNSAFE_CONFIGURE=1 ./configure prefix=/usr/local
make
make install
```
