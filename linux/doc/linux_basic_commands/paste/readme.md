# paste

The paste command is used to merge lines of files. Following are the commonly used switches.

```
| Switch | Action |
|-----|--------|
| -d | Specify delimiter |
| -s | Paste one file at a time instead of in parallel|
```
The best example to clearly understand the -s switch is see it −

```
[root@centosLocal Documents]# cat myOS.txt && cat lines.txt
Linux
Windows
Solaris
OS X
BSD
line 1
line 2
line 3
line 4
line 5
[root@centosLocal Documents]# past myOS.txt lines.txt

[root@centosLocal Documents]# paste myOS.txt lines.txt
Linux   line 1
Windows line 2
Solaris line 3
OS X    line 4
BSD line 5

[root@centosLocal Documents]# paste -s myOS.txt lines.txt
Linux   Windows Solaris OS X    BSD
line 1  line 2  line 3  line 4  line 5
[root@centosLocal Documents]#
```
So, if we wanted a ":" colon or Tab separated file by combining two different files, the paste command makes this fairly simple −

```
root@centosLocal Documents]# paste -d":"  myOS.txt lines.txt
Linux:line 1
Windows:line 2
Solaris:line 3
OS X:line 4
BSD:line 5

[root@centosLocal Documents]# paste -d"\\t"  myOS.txt lines.txt
Linux   line 1
Windows line 2
Solaris line 3
OS X    line 4
BSD line 5
[root@centosLocal Documents]#
```

With paste it's pretty easy to take a file, and make it into Tab separated columns −

```
[root@centosLocal Documents]# paste -d"\t" - - < lines.txt  
line 1  line 2
line 3  line 4
line 5   
[root@centosLocal Documents]#
```
