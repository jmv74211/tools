# File systems

When you are finished partitioning the hard disk, you can put a file system on each partition.

A file system is a way of organizing files on your partition. Besides file-based storage, file
systems usually include **directories** and **access control**, and contain meta information about
files like access times, modification times and file ownership.

The properties (length, character set, ...) of filenames are determined by the file system you
choose. Directories are usually implemented as files, you will have to learn how this is
implemented! Access control in file systems is tracked by user ownership (and group owner-
and membership) in combination with one or more access control lists.

## /proc/filesystems

The Linux kernel will inform you about currently loaded file system drivers in **/proc/
filesystems**.

```
root@rhel53 ~# cat /proc/filesystems | grep -v nodev
ext2
iso9660
ext3
```

When you mount a file
system without explicitly defining one, then mount will first try to probe **/etc/filesystems**
and then probe **/proc/filesystems** for all the filesystems without the **nodev** label. If **/etc/
filesystems** ends with a line containing only an asterisk (*) then both files are probed.

## /etc/filesystems

The **/etc/filesystems** file contains a list of autodetected filesystems (in case the **mount**
command is used without the **-t** option.

## Putting a file system on a partition

We now have a fresh partition. The system binaries to make file systems can be found with ls.

```
[root@RHEL4b ~]# ls -lS /sbin/mk*
-rwxr-xr-x 3 root root 34832 Apr 24 2006 /sbin/mke2fs
-rwxr-xr-x 3 root root 34832 Apr 24 2006 /sbin/mkfs.ext2
-rwxr-xr-x 3 root root 34832 Apr 24 2006 /sbin/mkfs.ext3
-rwxr-xr-x 3 root root 28484 Oct 13 2006 /sbin/mkdosfs
-rwxr-xr-x 3 root root 28484 Oct 13 2004 /sbin/mkfs.msdos
-rwxr-xr-x 3 root root 28484 Oct 13 2004 /sbin/mkfs.vfat
-rwxr-xr-x 1 root root 20313 Apr 10 2004 /sbin/mkinitrd
-rwxr-x--- 1 root root 15444 Oct 5  2006 /sbin/mkzonedb
-rwxr-xr-x 1 root root 15300 May 24 2004 /sbin/mkfs.cramfs
-rwxr-xr-x 1 root root 13036 May 24 2006 /sbin/mkswap
-rwxr-xr-x 1 root root 6912 May  24 2006 /sbin/mkfs
-rwxr-xr-x 1 root root 5905 Aug  3  2004 /sbin/mkbootdisk
[root@RHEL4b ~]#
```
It is time for you to read the manual pages of **mkfs** and **mke2fs**. In the example below,
you see the creation of an **ext2 file system** on /dev/sdb1. In real life, you might want to use
options like -m0 and -j.

```
root@RHELv4u2:~# mke2fs /dev/sdb1
mke2fs 1.35 (28-Feb-2004)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
28112 inodes, 112420 blocks
5621 blocks (5.00%) reserved for the super user
First data block=1
Maximum filesystem blocks=67371008
14 block groups
8192 blocks per group, 8192 fragments per group
2008 inodes per group
Superblock backups stored on blocks:
8193, 24577, 40961, 57345, 73729

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 37 mounts or
180 days, whichever comes first. Use tune2fs -c or -i to override.
```

### Tuning a file system

You can use **tune2fs** to list and set file system settings. The first screenshot lists the reserved
space for root (which is set at five percent).

```
[root@rhel4 ~]# tune2fs -l /dev/sda1 | grep -i "block count"
Block count: 104388
Reserved block count:  5219
[root@rhel4 ~]#
```

This example changes this value to ten percent. You can use tune2fs while the file system
is active, even if it is the root file system (as in this example).

```
[root@rhel4 ~]# tune2fs -m10 /dev/sda1
tune2fs 1.35 (28-Feb-2004)
Setting reserved blocks percentage to 10 (10430 blocks)
[root@rhel4 ~]# tune2fs -l /dev/sda1 | grep -i "block count"
Block count: 104388
Reserved block count: 10430
[root@rhel4 ~]#
```
# Checking a file system

The **fsck** command is a front end tool used to check a file system for errors.

```
[root@RHEL4b ~]# ls /sbin/*fsck*
/sbin/dosfsck /sbin/fsck /sbin/fsck.ext2 /sbin/fsck.msdos
/sbin/e2fsck /sbin/fsck.cramfs /sbin/fsck.ext3 /sbin/fsck.vfat
[root@RHEL4b ~]#
```

---

# Some examples:

1. List the filesystems that are known by your system.

   ```
   man fs
   cat /proc/filesystems
   cat /etc/filesystems (not on all Linux distributions)
   ```

2. Create an ext2 filesystem on the 200MB partition.

   ```
   mke2fs /dev/sdc1 (replace sdc1 with the correct partition)
   ```

3. Create an ext3 filesystem on one of the 300MB logical drives.

   ```
   mke2fs -j /dev/sdb5 (replace sdb5 with the correct partition)
   ```

4. Create an ext4 on the 400MB partition.

   ```
   mkfs.ext4 /dev/sdb1 (replace sdb1 with the correct partition)
   ```

5. Set the reserved space for root on the ext3 filesystem to 0 percent.

   ```
   tune2fs -m 0 /dev/sdb5
   ```

6. Verify your work with fdisk and df.

   ```
   mkfs (mke2fs) makes no difference in the output of these commands

   The big change is in the next topic: mounting
   ```

7. Perform a file system check on all the new file systems.

   ```
   fsck /dev/sdb1
   fsck /dev/sdc1
   fsck /dev/sdb5
   ```
