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
