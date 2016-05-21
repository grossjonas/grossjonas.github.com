---
layout: post
title: "Lords of Xulima and 64 Bit"
categories:
---

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
