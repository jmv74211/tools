# Erasing a hard disk

Before selling your old hard disk on the internet, it may be a good idea to erase it. By simply
repartitioning, or by using the Microsoft Windows format utility, or even after an **mkfs**
command, some people will still be able to read most of the data on the disk.

```
root@debian6~# aptitude search foremost autopsy sleuthkit | tr -s ' '
p autopsy - graphical interface to SleuthKit
p foremost - Forensics application to recover data
p sleuthkit - collection of tools for forensics analysis
```

Although technically the **/sbin/badblocks** tool is meant to look for bad blocks, you can use
it to completely erase all data from a disk. Since this is really writing to every sector of the
disk, it can take a long time!

```
root@RHELv4u2:~# badblocks -ws /dev/sdb
Testing with pattern 0xaa: done
Reading and comparing: done
Testing with pattern 0x55: done
Reading and comparing: done
Testing with pattern 0xff: done
Reading and comparing: done
Testing with pattern 0x00: done
Reading and comparing: done
```
The previous screenshot overwrites every sector of the disk **four times**. Erasing **once** with
a tool like dd is enough to destroy all data.
Warning, this screenshot shows how to permanently destroy all data on a block device.

```
[root@rhel65 ~]# dd if=/dev/zero of=/dev/sdb
```
