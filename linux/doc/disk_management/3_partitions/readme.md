# Partitions

Linux requires you to create one or more **partitions**. The next paragraphs will explain how
to create and use partitions.
A partition's **geometry** and size is usually defined by a starting and ending cylinder
(sometimes by sector). Partitions can be of type **primary** (maximum four), **extended**
(maximum one) or **logical** (contained within the extended partition). Each partition has a
**type field** that contains a code. This determines the computers operating system or the
partitions file system.

## Discover partitions

### fdisk -l

In the **fdisk -l** example below you can see that two partitions exist on **/dev/sdb**. The first
partition spans 31 cylinders and contains a Linux swap partition. The second partition is
much bigger.

```
root@laika:~# fdisk -l /dev/sdb
Disk /dev/sdb: 100.0 GB, 100030242816 bytes
255 heads, 63 sectors/track, 12161 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Device Boot    Start   End      Blocks     Id   System
/dev/sdb1        1     31       248976     82   Linux swap / Solaris
/dev/sdb2        32    12161    97434225   83   Linux
root@laika:~#
```

## Partitioning new disks

In the example below, we bought a new disk for our system. After the new hardware is
properly attached, you can use **fdisk** and **parted** to create the necessary partition(s). This
example uses **fdisk**, but there is nothing wrong with using **parted**.

### Recognising the disk

First, we check with fdisk -l whether Linux can see the new disk. Yes it does, the new disk
is seen as /dev/sdb, but it does not have any partitions yet.

```
root@RHELv4u2:~# fdisk -l
Disk /dev/sda: 12.8 GB, 12884901888 bytes
255 heads, 63 sectors/track, 1566 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Device Boot    Start   End    Blocks     Id   System
/dev/sda1  *    1      13     104391     83   Linux
/dev/sda2       14     1566   12474472+  8e   Linux LVM

Disk /dev/sdb: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/sdb doesn't contain a valid partition table
```

### Opening the disk with fdisk

Then we create a partition with fdisk on /dev/sdb. First we start the fdisk tool with /dev/sdb
as argument. Be very very careful not to partition the wrong disk!!

```
root@RHELv4u2:~# fdisk /dev/sdb
Device contains neither a valid DOS partition table, nor Sun, SGI...
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.
Warning: invalid flag 0x0000 of partition table 4 will be corrected...
```

### Empty partition table

Inside the fdisk tool, we can issue the **p** command to see the current disks partition table.

```
Command (m for help): p
Disk /dev/sdb: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Device Boot  Start  End  Blocks  Id  System
```

### Create a new partition

No partitions exist yet, so we issue **n** to create a new partition. We choose p for primary, 1
for the partition number, 1 for the start cylinder and 14 for the end cylinder.

```
Command (m for help): n
Command action
e extended
p primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-130, default 1):
Using default value 1
Last cylinder or +size or +sizeM or +sizeK (1-130, default 130): 14
```

We can now issue p again to verify our changes, but they are not yet written to disk. This
means we can still cancel this operation! But it looks good, so we use **w** to write the changes
to disk, and then quit the fdisk tool.

```
Command (m for help): p
Disk /dev/sdb: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Device Boot   Start   End  Blocks   Id   System
/dev/sdb1      1      14   112423+  83   Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
root@RHELv4u2:~#
```

### Display the new partition

Let's verify again with **fdisk -l** to make sure reality fits our dreams. Indeed, the screenshot
below now shows a partition on /dev/sdb.

```
root@RHELv4u2:~# fdisk -l
Disk /dev/sda: 12.8 GB, 12884901888 bytes
255 heads, 63 sectors/track, 1566 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Device Boot    Start   End   Blocks     Id   System
/dev/sda1  *    1      13    104391     83   Linux
/dev/sda2       14     1566  12474472+  8e   Linux LVM

Disk /dev/sdb: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Device Boot  Start  End   Blocks     Id   System
/dev/sdb1     1      14   112423+    83   Linux
root@RHELv4u2:~#
```

---

## Partition table

### GUID partition table

**gpt** was developed because of the limitations of the 1980s **mbr** partitioning scheme (for
example only four partitions can be defined, and they have a maximum size two terabytes).

Since 2010 **gpt** is a part of the **uefi** specification, but it is also used on **bios** systems.

Newer versions of **fdisk** work fine with **gpt**, but most production servers today (mid 2015)
still have an older **fdisk**. You can use **parted** instead.

### Labeling with parted

**parted** is an interactive tool, just like **fdisk**. Type **help** in **parted** for a list of commands
and options.

This screenshot shows how to start **parted** to manage partitions on **/dev/sdb**.

```
[root@rhel71 ~]# parted /dev/sdb
GNU Parted 3.1
Using /dev/sdb
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted)
```

Each command also has built-in help. For example **help mklabel** will list all supported
labels. Note that we only discussed **mbr**(msdos) and **gpt** in this book.

```
(parted) help mklabel
mklabel,mktable LABEL-TYPE  create a new disklabel (partition table)

   LABEL-TYPE is one of: aix, amiga, bsd, dvh, gpt, mac, msdos, pc98, sun, loop
(parted)
```

We create an mbr label.

```
(parted) mklabel msdos>
Warning: The existing disk label on /dev/sdb will be destroyed and all data on. Do you want to continue?
Yes/No? yes

(parted) mklabel gpt
Warning: The existing disk label on /dev/sdb will be destroyed and all data on. Do you want to continue?
Yes/No? Y
(parted)
```
### Partitioning with Parted

Once labeled it is easy to create partitions with **parted**. This screenshot starts with an
unpartitioned (but **gpt** labeled) disk.

```
(parted) print
Model: ATA VBOX HARDDISK (scsi)
Disk /dev/sdb: 8590MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start  End  Size  File system  Name  Flags

(parted)
```

This example shows how to create two primary partitions of equal size.

```
(parted) mkpart primary 0 50%
Warning: The resulting partition is not properly aligned for best performance.
Ignore/Cancel? I
(parted) mkpart primary 50% 100%
(parted)
```

Verify with **print** and exit with **quit**. Since **parted** works directly on the disk, there is no
need to **w(rite)** like in **fdisk**.

```
(parted) print
Model: ATA VBOX HARDDISK (scsi)
Disk /dev/sdb: 8590MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start    End     Size     File system  Name      Flags
 1      17.4kB   4295MB  4295MB                primary
 2      4295MB   8589MB  4294MB                primary

(parted) quit
Information: You may need to update /etc/fstab.

[root@rhel71 ~]#
```
---

## Create backup of master boot record

The **partition table** information (primary and extended partitions) is written in the **master
boot record** or **mbr**. You can use **dd** to copy the mbr to a file.

This example copies the master boot record from the first SCSI hard disk.

```
dd if=/dev/sda of=/SCSIdisk.mbr bs=512 count=1
```

The same tool can also be used to wipe out all information about partitions on a disk. This
example writes zeroes over the master boot record.

```
dd if=/dev/zero of=/dev/sda bs=512 count=1
```

Or to wipe out the whole partition or disk.

```
dd if=/dev/zero of=/dev/sda
```

**partprobe**

Don't forget that after restoring a **master boot record** with **dd**, that you need to force the
kernel to reread the partition table with **partprobe**. After running **partprobe**, the partitions
can be used again.

```
[root@RHEL5 ~]# partprobe
[root@RHEL5 ~]#
```

**logical drives**

The **partition table** does not contain information about **logical drives**. So the **dd** backup
of the **mbr** only works for primary and extended partitions. To backup the partition table
including the logical drives, you can use **sfdisk**.


This example shows how to backup all partition and logical drive information to a file.

```
sfdisk -d /dev/sda > parttable.sda.sfdisk
```

The following example copies the **mbr** and all **logical drive** info from /dev/sda to /dev/sdb

```
sfdisk -d /dev/sda | sfdisk /dev/sdb
```

---

# Some examples

1. Use fdisk -l to display existing partitions and sizes.

```
as root: # fdisk -l
```

2. Use df -h to display existing partitions and sizes.

```
df -h
```

3. Compare the output of fdisk and df.

```
Some partitions will be listed in both outputs (maybe /dev/sda1 or /dev/hda1).
```

4. Create a 200MB primary partition on a small disk.

```
Choose one of the disks you added (this example uses /dev/sdc).
root@rhel53 ~# fdisk /dev/sdc
...
Command (m for help): n
Command action
  e extended
  p primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-261, default 1): 1
Last cylinder or +size or +sizeM or +sizeK (1-261, default 261): +200m
Command (m for help): w
The partition table has been altered!
Calling ioctl() to re-read partition table.
Syncing disks.
```

5. Create a 400MB primary partition and two 300MB logical drives on a big disk.

```
Choose one of the disks you added (this example uses /dev/sdb)
fdisk /dev/sdb
inside fdisk : n p 1 +400m enter --- n e 2 enter enter --- n l +300m (twice)
```

6. Use df -h and fdisk -l to verify your work.

```
fdisk -l ; df -h
```

7. Compare the output again of fdisk and df. Do both commands display the new partitions ?

```
The newly created partitions are visible with fdisk.
But they are not displayed by df.
```

8. Create a backup with dd of the mbr that contains your 200MB primary partition.

```
dd if=/dev/sdc of=bootsector.sdc.dd count=1 bs=512
```

9. Take a backup of the partition table containing your 400MB primary and 300MB logical drives. Make sure the logical drives are in the backup.

```
sfdisk -d /dev/sdb > parttable.sdb.sfdisk
```
