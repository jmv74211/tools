# wc

**wc** is useful for counting occurrences in a file. It helps print newline, word, ad byte count
from each file. Most useful is when combined with grep to show matches for a certain
pattern.

| Switch | Action |
|-----|--------|
| -c | Bytes |
| -m | Character count |
| -l | Line count |
| -L | Length of the longest line |

We can see our system has 5 users with a group id of 0. Then upon further inspection only
the root user has shell access.

```
[root@centosLocal centos]# cat /etc/passwd | cut -d":" -f4 | grep "^0" |
wc -l
5
[root@centosLocal centos]# cat /etc/passwd | cut -d":" -f4,5,6,7 | grep "^0"
0:root:/root:/bin/bash
0:sync:/sbin:/bin/sync
0:shutdown:/sbin:/sbin/shutdown
0:halt:/sbin:/sbin/halt
0:operator:/root:/sbin/nologin
[root@centosLocal centos]#
```
