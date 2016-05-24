---
layout: post
title: "Lords of Xulima and 64 Bit"
categories:
---

Recently I had problems running Lords of Xulima on my 64 bit linux machines - arch and open suse. After some googling I found the solution in the [arch forums](https://bbs.archlinux.org/viewtopic.php?id=206520). Here is the fix:

Replace

```
${xulima_installation_dir}/game/libbass.so
```


with the extracted version from

[un4seen](http://www.un4seen.com/download.php?bass24-linux)

then

``` bash
cd ${xulima_installation_dir}/game
mono LoX.exe
```

if that succeeds

```
cd ${xulima_installation_dir}
mv start.sh start.sh.original.backUp

cat << EOF > start.sh
#!/bin/bash

cd game
mono LoX.exe

EOF
```

now it should be runnable via the `.desktop` file again
