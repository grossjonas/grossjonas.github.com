---
layout: post
title: "Lords of Xulima and 64 Bit"
categories:
---

Recently I had problems running Lords of Xulima on my 64 bit linux machines - arch and open suse. After some googling I found the solution in the [arch forums](https://bbs.archlinux.org/viewtopic.php?id=206520). Here is the fix:

Replace `libbass.so` with the extracted version from

[un4seen](http://www.un4seen.com/download.php?bass24-linux)

like this (`${xulima_installation_dir}` might be something like `/home/user/GOG Games/Lords of Xulima`)

``` bash
cd "${xulima_installation_dir}/game"
mv libbass.so libbass.so.original.backUp

mkdir -p /tmp/bass24-linux
cd /tmp/bass24-linux
wget "http://www.un4seen.com/files/bass24-linux.zip"
unzip bass24-linux.zip

cp x64/libbass.so "${xulima_installation_dir}/game/"
```

then

``` bash
cd "${xulima_installation_dir}/game"
mono LoX.exe
```

if that succeeds

``` bash
cd "${xulima_installation_dir}"
mv start.sh start.sh.original.backUp

cat << EOF > start.sh
#!/bin/bash

cd game
mono LoX.exe

EOF

chmod +x start.sh

```

now it should be runnable via the `.desktop` file again
