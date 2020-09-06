# grep

**grep** is commonly used by administrators to:

- Find files with a specific text string
- Search for a text string in logs
- Filter command out, focusing on a particular string

Following is a list of common switches used with grep.

| Switch | Action |
|-----|--------|
| -E * | Interpret pattern as a regular expression |
| -G * | Interpret pattern as a basic regular expression |
| -c | Suppress normal output, only show the number of matches |
| -l | List files with matches |
| -n | Prefix each |
| -m | Stop reading after the number of matching lines |
| -o | Print only the matching parts of matching lines, per line (useful with pattern matches) |
| -v | Invert matches, showing non-matches |
| -i | Case insensitive search |
| -r | Use grep recursively |

Search for errors X Server errors in Xorg logs:

```
[root@centosLocal log]# grep error ./Xorg*.log
./Xorg.0.log: (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
./Xorg.1.log: (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
./Xorg.9.log: (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[root@centosLocal log]#
```

Check for possible RDP attacks on an imported Windows Server firewall log.

```
[root@centosLocal Documents]# grep 3389 ./pfirewall.log | grep " 146." | wc -l
326
[root@centosLocal Documents]#
```

As seen in the above example, we had 326 Remote Desktop login attempts from IPv4 class A range in less than 24 hours. The offending IP Address has been hidden for privacy reasons. These were all from the same IPv4 address. Quick as that, we have tangible evidence to block some IPv4 ranges in firewalls.

grep can be a fairly complex command. However, a Linux administrator needs to get a firm grasp on. In an average day, a Linux System Admin can use a dozen variations of grep.
