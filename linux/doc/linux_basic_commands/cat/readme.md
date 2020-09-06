# cat

The cat command is used to concatenate files and print to standard output. Formerly, we
have demonstrated both uses and abuses with the cat command. cat servers the following
distinct purposes:

- Show files contents
- Write contents of one file to another file
- Combine multiple files into a single file
- Support special features: adding line numbers, showing special characters, eliminating blank lines

| Switch | Action |
|-----|--------|
| -b | Number non-blank lines |
| -E | Show line ends |
| -T | Show tabs |
| -s | Squeeze blank, suppress repeated empty lines |

As noted previously, when using utilities such as grep, sort, and uniq we want to avoid
piping output from cat if possible. We did this for simple demonstration of piping
commands earlier. However, knowing when to perform an operation with a utility like grep
is what separates Linux Administrators from Linux end-users.

**Bad Habit**

```
[root@centosLocal centos]# cat /etc/passwd | sort -t: -k1
| grep ":0"
halt:x:7:0:halt:/sbin:/sbin/halt
operator:x:11:0:operator:/root:/sbin/nologin
root:x:0:0:root:/root:/bin/bash
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
sync:x:5:0:sync:/sbin:/bin/sync
[root@centosLocal centos]#
```

**Good Habit**

```
[root@centosLocal centos]# grep ":0" /etc/passwd | sort -t: -k 1
halt:x:7:0:halt:/sbin:/sbin/halt
operator:x:11:0:operator:/root:/sbin/nologin
root:x:0:0:root:/root:/bin/bash
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
sync:x:5:0:sync:/sbin:/bin/sync
[root@centosLocal centos]#
```

> **Note:** piping cat to secondary commands like sort or grep should only be done when it is needed.

One common use of cat is when dealing with Windows formatted line breaks. Both Linux
and Windows by internal design, use a different control code to represent End Of Line
(EOL):

```
* Linux line break is always a Line Feed: LF or depicted as "\n".
* Windows is Carriage Return followed by a Line Feed: CR LF or depicted as
"\r\n".
* Macintosh, in all moderne releases of OS X and now macOS, has adopted the
Linux/Unix standard of LF or "\n"
```
So, let's say we open our file in a GUI text-editor like gedit or are experiencing random
issues while applying filtering commands. Text appears on a single line, or filtering
commands do not operate as expected.
Especially, when the text file was downloaded off the Internet, we want to check line
breaks. Following is a sample output from cat showing EOL characters.

```
[root@centosLocal centos]# cat -E
./Desktop/WinNames.txt
$ed:Daniel:101
$enny:Colon:608
$ana:Maxwell:602
$arian:Little:903
$obbie:Chapman:403
$icolas:Singleton:203
$ale:Barton:901
```

Notice the preceding "**$**" on each line? Linux is reading the CR "\n", breaking the file. Then
translating a Carriage Return over the first character of each file.
When viewed without the -E switch, the file looks fine:

```
[root@centosLocal centos]# cat
./Desktop/WinNames.txt
Ted:Daniel:101
Jenny:Colon:608
Dana:Maxwell:602
Marian:Little:903
Bobbie:Chapman:403
Nicolas:Singleton:203
Dale:Barton:901
```
Luckily, with Linux filtering commands this is an easy fix:

```
[root@centosLocal centos]# sed -i 's/\r$//g' ./Desktop/WinNames.txt
[root@centosLocal centos]# cat -E ./Desktop/WinNames.txt
Ted:Daniel:101$
Jenny:Colon:608$
Dana:Maxwell:602$
```

> **Note:** When viewed with the -E switch, all Linux line breaks will end in $.
