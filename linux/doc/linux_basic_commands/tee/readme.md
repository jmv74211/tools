# tee

**tee** is a simple command, letting an administrator write command output and view a file
at the same time. This simple command can save time over first writing stdout to a file,
then viewing the file contents.

Following are the common Switches used with tee.

| Command | Action |
|-----|--------|
| -a| Append to files instead of clobber file |
| -i | Ignore interrupts (for advanced use in scripting mostly) |

Without **tee** to both view and write files and directories in /etc, where each begins with the letter "a".

```
[root@centosLocal Documents]# ls -d /etc/a*
/etc/abrt
/etc/aliases.db
/etc/autofs.conf
/etc/anacrontab
/etc/auto.master.d
/etc/asound.conf /etc/auto.smb
/etc/audisp /etc/autofs_ldap_auth.conf
/etc/aliases
/etc/alternatives
/etc/adjtime
/etc/at.deny
/etc/at-spi2
/etc/alsa
/etc/auto.misc
/etc/audit
/etc/avahi
/etc/auto.master
/etc/auto.net
[root@centosLocal Documents]# ls -d /etc/a* > ./etc_report_a.txt
[root@centosLocal Documents]# cat ./etc_report_a.txt
/etc/abrt
/etc/adjtime
/etc/aliases
/etc/aliases.db
/etc/alsa
/etc/alternatives
/etc/anacrontab
/etc/asound.conf
/etc/at.deny
/etc/at-spi2
/etc/audisp
/etc/audit
/etc/autofs.conf
/etc/autofs_ldap_auth.conf
/etc/auto.master
/etc/auto.master.d
/etc/auto.misc
/etc/auto.net
/etc/auto.smb
/etc/avahi
[root@centosLocal Documents]#
```

This small task is much more efficient with the tee command.

```
[root@centosLocal Documents]# ls -d /etc/a* | tee ./etc_report_a.txt
/etc/abrt
/etc/adjtime
/etc/aliases
/etc/aliases.db
/etc/alsa
/etc/alternatives
/etc/anacrontab
/etc/asound.conf
/etc/at.deny
/etc/at-spi2
/etc/audisp
/etc/audit
/etc/autofs.conf
/etc/autofs_ldap_auth.conf
/etc/auto.master
/etc/auto.master.d
/etc/auto.misc
/etc/auto.net
/etc/auto.smb
/etc/avahi
[root@centosLocal Documents]#
```
