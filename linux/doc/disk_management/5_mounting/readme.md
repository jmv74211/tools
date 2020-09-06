# Mounting

Once you've put a file system on a partition, you can **mount** it. Mounting a file system
makes it available for use, usually as a directory. We say **mounting a file system** instead
of mounting a partition because we will see later that we can also mount file systems that
do not exists on partitions.

On all **Unix** systems, every file and every directory is part of one big file tree. To access
a file, you need to know the full path starting from the root directory. When adding a **file
system** to your computer, you need to make it available somewhere in the file tree. The
directory where you make a file system available is called a **mount point**.

## mount

When the **mount point** is created, and a **file system** is present on the partition, then **mount** can mount the file system on the **mount point directory**.

When mounting a file system without specifying explicitly the file system, then **mount** will
first probe `/etc/filesystems`. Mount will skip lines with the **nodev** directive.

```
paul@RHELv4u4:~$ cat /etc/filesystems
ext3
ext2
nodev proc
nodev devpts
iso9660
vfat
hfs
```

When `/etc/filesystems` does not exist, or ends with a single * on the last line, then **mount** will read `/proc/filesystems`.

```
[root@RHEL52 ~]# cat /proc/filesystems | grep -v ^nodev
ext2
iso9660
ext3
```

## umount

You can **unmount** a mounted file system using the **umount** command.

```
root@pasha:~# umount /home/reet
```

## Displaying mounted file systems

To display all mounted file systems, issue the **mount** command. Or look at the files **/proc/mounts** and **/etc/mtab**.

### df

A more user friendly way to look at mounted file systems is **df**. The **df (diskfree** command has the added benefit of showing you the free space on each mounted disk. Like a lot of Linux commands, **df** supports the **-h** switch to make the output more **human readable**.

```
root@laika:~# df -h | egrep -e "(sdb2|File)"
Filesystem Size Used Avail Use% Mounted on
/dev/sdb2  92G  83G 8.6G 91% /media/sdb2
```

### du

The **du** command can summarize **disk usage** for files and directories. By using **du** on a mount point you effectively get the disk space used on a file system.

While **du** can go display each subdirectory recursively, the **-s** option will give you a total
summary for the parent directory. This option is often used together with **-h**. This means **du -sh** on a mount point gives the total amount used by the file system in that partition.

```
root@debian6~# du -sh /boot /srv/wolf
6.2M /boot
1.1T /srv/wolf
```
### from start to finish

Below is a screenshot that show a summary roadmap starting with detection of the hardware
(/dev/sdb) up until mounting on **/mnt**.

```
[root@centos65 ~]# **dmesg | grep '\[sdb\]'**
sd 3:0:0:0: [sdb] 150994944 512-byte logical blocks: (77.3 GB/72.0 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support \
DPO or FUA
sd 3:0:0:0: [sdb] Attached SCSI disk

[root@centos65 ~]# **parted /dev/sdb**

(parted) **mklabel msdos**
(parted) **mkpart primary ext4 1 77000**
(parted) **print**
Model: ATA VBOX HARDDISK (scsi)
Disk /dev/sdb: 77.3GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start    End     Size    Type     File system  Flags
1       1049kB   77.0GB  77.0GB  primary

(parted) **quit**

[root@centos65 ~]# **mkfs.ext4 /dev/sdb1**
mke2fs 1.41.12 (17-May-2010)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
4702208 inodes, 18798592 blocks
939929 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=4294967296
574 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
( output truncated )
...

[root@centos65 ~]# mount /dev/sdb1 /mnt

[root@centos65 ~]# mount | grep mnt
/dev/sdb1 on /mnt type ext4 (rw)

[root@centos65 ~]# df -h | grep mnt
/dev/sdb1 71G 180M  67G  1% /mnt

[root@centos65 ~]# du -sh /mnt
20K  /mnt

[root@centos65 ~]# umount /mnt
```

## Permanent mounts

Until now, we performed all mounts manually. This works nice, until the next reboot.
Luckily there is a way to tell your computer to automatically mount certain file systems
during boot.

### /etc/fstab

The file system table located in **/etc/fstab** contains a list of file systems, with an option to
automtically mount each of them at boot time.

Below is a sample **/etc/fstab** file.

```
root@RHELv4u2:~# cat /etc/fstab
/dev/VolGroup00/LogVol00   /         ext3   defaults       1 1
LABEL=/boot                /boot     ext3   defaults       1 2
none                       /dev/pts  devpts gid=5,mode=620 0 0
none                       /dev/shm  tmpfs  defaults       0 0
none                       /proc     proc   defaults       0 0
none                       /sys      sysfs  defaults       0 0
/dev/VolGroup00/LogVol01   swap      swap   defaults       0 0
```

By adding the following line, we can automate the mounting of a file system.

```
/dev/sdb1  /home/project42  ext2  defaults  0 0
```

## Security mounts

File systems can be secured with several mount options. Here are some examples.

### ro

The **ro** option will mount a file system as read only, preventing anyone from writing.

```
root@rhel53 ~# mount -t ext2 -o ro /dev/hdb1 /home/project42
root@rhel53 ~# touch /home/project42/testwrite
touch: cannot touch `/home/project42/testwrite': Read-only file system
```

### no exec

The **noexec** option will prevent the execution of binaries and scripts on the mounted file
system.

```
root@rhel53 ~# mount -t ext2 -o noexec /dev/hdb1 /home/project42
root@rhel53 ~# cp /bin/cat /home/project42
root@rhel53 ~# /home/project42/cat /etc/hosts
-bash: /home/project42/cat: Permission denied
root@rhel53 ~# echo echo hello > /home/project42/helloscript
root@rhel53 ~# chmod +x /home/project42/helloscript
root@rhel53 ~# /home/project42/helloscript
-bash: /home/project42/helloscript: Permission denied
```

## Mouting remote file systems

### nfs

Unix servers often use **nfs** (aka the network file system) to share directories over the network.
Setting up an nfs server is discussed later. Connecting as a client to an nfs server is done
with **mount**, and is very similar to connecting to local storage.

This command shows how to connect to the nfs server named **server42**, which is sharing
the directory **/srv/data**. The **mount point** at the end of the command (**/home/data**) must
already exist.

```
[root@centos65 ~]# mount -t nfs server42:/srv/data /home/data
[root@centos65 ~]#
```

If this **server42** has ip-address **10.0.0.42** then you can also write:

```
[root@centos65 ~]# mount -t nfs 10.0.0.42:/srv/data /home/data
[root@centos65 ~]# mount | grep data
10.0.0.42:/srv/data on /home/data type nfs (rw,vers=4,addr=10.0.0.42,clienta\
ddr=10.0.0.33)
```
