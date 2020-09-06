# head

**head** is a basic opposite of tail in relation to what part of the file operations are performed
on. By default, head will read the first 10 lines of a file.

**head** offers similar options as tail:

| Switch | Action |
|-----|--------|
| -c | Output last denoted in kilobytes |
| -n | Output n number of lines from eof |
| -q | No headers only file content |

> Note: Head offers no **-f** option, since the files are appended from the bottom.

**head** is useful for reading descriptions of configuration files. When making such a file, it
is a good idea to use the first 10 lines effectively.

```
[root@centosLocal centos]# head /etc/sudoers
## Sudoers allows particular users to run various commands as
## the root user, without needing the root password.
##
## Examples are provided at the bottom of the file for collections
## of related commands, which can then be delegated out to particular
## users or groups.
##
## This file must be edited with the 'visudo' command.
## Host Aliases
[root@centosLocal centos]#
```
