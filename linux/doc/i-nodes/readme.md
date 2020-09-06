# What are the inodes and dentries of a file system?

Quite a few GNU / Linux users, web servers and / or email servers have listened to talk about inodes and don't know what they are. For this reason, next we will see what inode-based file systems are and how they work.

## What are the inodes?

An inode is a data structure that stores information about a file in our file system.

An inode has no name and is identified by a unique integer. Each inode can only contain data from a single file in the file system. Therefore, if we have 4 files and 4 directories we will be using 8 inodes.

Some of the file systems that work with inodes are:

- ext2 / 3/4.
- ReiserFS
- FFS
- XFS
- Btrfs
- etc.

Windows and MacOS do not work with inodes because their file systems are Ntfs and HFS +. They only work with inode operating systems such as UNIX, FreeBSD, GNU-Linux and other Unix-based operating systems.

**What kind of information do inodes store in files and directories?**

An inode contains all the metadata of a file in our file system.

The metadata stored in an inode are the following:

- **Inode number** The inode number is a unique integer that serves to identify an inode.
- **File size** as well as the number of blocks the file occupies on the hard disk.
- The **storage device** in which the file is stored. (Device ID)
- **Number of links** Therefore if there are 2 files that point to the same inode we will have 2 links. If we have a directory that contains 15 files we will have 15 links.
- The user identifier ( **UID** or User ID). Therefore, the inodes specify the owner of a file.
- The group identifier ( **GID** or Group ID). Thus, an inode contains the group to which a file belongs.
- **Timestamps** such as the date the file was created, the date of the last access, etc.
- **Addressing table** where the blocks of the hard disk in which the file is stored are detailed.

Through the stat command we can consult the information that an inode stores about a file. If we execute the stat command followed by the name of a file, directory or link we will get the following result:

```
joan@debian : ~ $ stat file_1
File: File_1
Size : 7872 Blocks : 16 I / O Block : 4096 regular file
Device : 805h / 2053d Node-i : 1326361 Links : 1
Access : (0644 / -rw-r – r–) Uid : (1000 / joan) Gid : (1000 / joan)
Access : 2018-02-04 21: 04: 11.902405984 +0100
Modification : 2016-12-25 11: 24: 27.051411224 +0100
Change : 2016-12-25 11: 25: 06.898576813 +0100
Creation : -
```

As you can see, the output of the command contains the information stored by inode *1326361* about the file `file_1` .

The main function of the information stored in the inode is that we can access the information stored on our hard drive.

**What type of information do dentries store?**

Dentries have the function of defining the structure of a directory. The dentries, together with the inodes, will be responsible for representing a file in memory.

Dentries in a directory are stored in a table. This table contains all the names of the files that are inside the directory and associates them with their corresponding inode number. Therefore, a dentry is a name that points to an inode.

Imagine that the Documents directory contains 2 files and a directory . The inode representing the Documents directory will be the following:

| Files within the Documentes directory | Inode |
|---------------------------------------|-------|
| . | 10000 |
| .. | 5000 |
| Letter.odt | 10043 |
| CV.odt | 10025 |
| Directory 1 | 13412 |

The content of the table is simple to understand. It is only necessary to comment on entries that have one point and two points.

The entry with a period (.) Refers to the Documents directory. Therefore the information in the Documents directory is stored in inode 10000.

The entry with 2 dots (..) refers to the inode of the directory that contains the Documents directory. Therefore, if the Documents folder is inside / home / user , inode 5000 refers to the user directory.

To better understand everything we have said so far, imagine the following structure:

```
          ROOT(/)
         /
      home
       |
      joan  -------- angel
        |
      letter.odt ---  photos

```

- **Use 6 inodes**. The first inode for the root directory, the second for the home directory, the third for the joan directory, the fourth for the angel directory, the fifth for the letter.odt file and the sixth for the photos directory.

- **Use 5 dentries**. The first link letter.odt with joan, the second link photos with joan, the third link joan with home, the fourth link angel with home and finally the last link home with the root directory.

## What space does a inode occupy?

If you want to check the space that an inode occupies in your file system you just have to do the following.

Initially they execute the following command to see the file system partitions:

```
joan@debian : ~ $ sudo fdisk -l
Disk / dev / sda: 298.1 GiB, 320072933376 bytes, 625142448 sectors
Units: 1 * 512 sectors = 512 bytes
Sector size (logical / physical): 512 bytes / 512 bytes
I / O size (minimum / optimal): 512 bytes / 512 bytes
Disc label type: two
Disk ID: 0x29f429f3 Devices. Start Start End Sectors Size Id Type
/ dev / sda1 * 63 122698574 122698512 58.5G 7 HPFS / NTFS / exFAT
/ dev / sda2 122699776 123619327 919552 449M 27 NTFS of WinRE hidden
/ dev / sda3 123620175 182916089 59295915 28.3G 83 Linux
/ dev / sda4 182916151 625137344 442221194 210.9G f W95 Ext'd (LBA)
/ dev / sda5 182916153 235063079 52146927 24.9G 83 Linux
/ dev / sda6 235063143 237296114 2232972 1.1G 82 Linux swap / Solaris
/ dev / sda7 237297664 237631487 333824 163M 83 Linux
/ dev / sda8 237633543 625137344 387503802 184.8G 7 HPFS / NTFS / exFAT
```

Of the 8 partitions I will look at the size of the inodes in the / dev / sda5 and / dev / sda7 partitions . To do this I will execute the following commands:

```
joan@debian : ~ $ sudo tune2fs -l / dev / sda5 | grep Inode
Inode count: 1630208
Inodes per group: 8192
Inode blocks per group: 512
Inode size: 256
```
```
joan@debian : ~ $ sudo tune2fs -l / dev / sda7 | grep Inode
Inode count: 41832
Inodes per group: 1992
Inode blocks per group: 249
Inode size: 128
```

As you can see, the partition inodes (/ dev / sda5) are `256 bytes` in size. This is because the ext4 file systems usually have this default size.

On the other hand the partition inodes (/ dev / sda7) have a size of `128 bytes`. It is also a usual size in ext2 file systems.

Therefore if the inodes of my / home partition have 256 bytes and the blocks of my hard drive are 4096 bytes, each block of my hard drive can store 16 inodes.

##  Modify the number and size of inodes in ext4 file systems

The inodes are created at the moment the file system is generated. Once the file system is generated, it will not be possible to add and / or resize the inodes.

> Note: There are file systems such as JFS, Btrfs or XFS that allow you to increase the number of inodes of a file system.

> Note: In LVM partitions and in traditional partitions we can increase the number of inodes by adding more space to a partition.

If we want to control the number and size of the inodes we can do it when formatting our partitions. To do this they must use a command of the following type:

```
sudo mkfs.  ext4 -N 2,000,000 -I 256 / dev / sdaX
```

If we execute this command, the `sdaX` partition will be *formatted* . At the time of formatting, an ext4 file system will be created that will contain 2,000,000 inodes. Each of these inodes will occupy a size of 256 bytes.

We have to be careful with the following aspects:

- The size of the inodes must be a power of 2 equal to or greater than 128 bytes. The recommended inode sizes are 128 or 256 bytes.

- The ideal number of inodes will be based on the size of the partition and the needs of each user.

- If you choose a very large inode size and / or a large number of inodes, the storage capacity of the hard disk will be reduced.

- There are additional parameters to control the number of generated inodes such as -i bytes-per-inode, -T usage-type [, ...], etc.

It is not recommended that users with little knowledge play with these values. A user with little knowledge is better to use the following command to format a partition:

```
sudo mkfs.ext4 / dev / sdaX
```

**In what position are the inodes located on the hard disk?**

The location of the inodes inside the hard disk depends on the file system we use. For example:

- There are file systems that position all of the inodes at the start of the hard disk.

- There are other file systems, such as ext4, that divide the hard drive into 4 zones. In the beginning of each one of the zones the tables of inodes are located. The inodes of each zone redirect to blocks of the hard disk as close to the location of the inode. This minimizes head displacement on traditional hard drives.

## Check information about inodes

Below you will see a series of commands that may be useful to find out information about the inodes of your file system.

**See the free and busy file system inodes**

To see the free and busy inodes of the file system partitions we have to execute the following command:

```
joan@debian : ~ $ df -i
S. files Nodos-i NUsados ​​NLibres NUso% Mounted on
udev 404955 531 404424 1% / dev
tmpfs 408507 870 407637 1% / run
/ dev / sda3 1855952 571568 1284384 31% /
tmpfs 408507 63 408444 1% / dev / shm
tmpfs 408507 4 408503 1% / run / lock
tmpfs 408507 16 408491 1% / sys / fs / cgroup
/ dev / sda5 1630208 143964 1486244 9% / home
/ dev / sda7 41832 371 41461 1% / boot
/ dev / sda8 70674942 7362 70667580 1% / average / DATA
tmpfs 408507 33 408474 1% / run / user / 1000
```

If we look at the results we will see that in my case I am not occupying a large amount of inodes.

**See the inode number of any file we have stored**

To see the inode number of each and every one of the elements contained in a directory we have to execute the following command:

```
joan@debian : ~ $ ls -i
1326361 file_1
1310734 Images
1041 'Ninja IDE'
1332060 ps_mem.py
1325239 file_2
400342 jd2
1321034 nohup.out
1310731 Public
1326293 Audiobooks
322476 jdownloader
……
```

**Find out the inode that uses a file or folder**

To know the inode that uses a file, a folder or a link, we just have to type the ls -i command followed by the **name of the file, folder or link**.

Therefore, to find out the inode of `file_1` we will execute the following command in the terminal:

```
joan@debian : ~ $ ls -i file_1
1326361 file_1
```

**Search the name of a file by its inode number**

With the find command we can search for a file for its inode number. If we want to find the file that corresponds to inode 523580, we will execute the following command:

```
joan@debian : ~ $ sudo find / -inum 523580
/var/cache/apt/pkgcache.bin
```
In this case we can see that inode 523580 corresponds to the pkgcache.bin file.

---

**Reference:** https://geekland.eu/inodos-dentires-sistema-archivos/https://geekland.eu/inodos-dentires-sistema-archivos/
