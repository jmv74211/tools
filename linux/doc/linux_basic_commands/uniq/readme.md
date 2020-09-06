# uniq

Following are the common switches used with uniq. This command reports or omits repeated lines.

| Switch | Action |
|-----|--------|
| -c | Prefix lines by the number of occurrence |
| -i | Ignore case |
| -u | Only print unique lines |
| -w | Check chars, compare no more than n chars |
| -s | Skip chars, avoid comparing the first two N characters |
| -f | Skip fields, avoid comparing first N fields |
| -D | Print all duplicate line groups |

We have briefly used uniq in a few examples prior. The uniq command allows us to filter the lines of files based on matches. For example, say we got a second employee named Matt Davis in Sales. Three days later, Accounting needs new estimates for Sales Participation Awards for next quarter. We can check the employee list using the following command.

```
[root@centosLocal centos]# cat ./Documents/names.txt | wc -l
30
[root@centosLocal centos]#
```

We tell them 30 people in Sales for the annual participation awards. There might be a
good chance Accounting will notice a discrepancy: they only needed 29 unique award
plaques produced. Let's try again:

```
[root@centosLocal Documents]# cut -d ":" -f 1,2 ./names.txt | sort | uniq | wc
-l
29
[root@centosLocal Documents]#
```

Now we have enough information to give Accounting an accurate number of unique
Participation Awards for the Sales Department (they will not need to pay to have two
unique plaques made. Just duplicate a second for "Matt Davis").
Note: When looking for unique lines, we always want to use sort, piping its output to uniq.
If non-uniq entries are not inline sequence, they will not be seen as duplicate lines.
To quickly generate a report letting us know how many sales people share an office:

```
[root@centosLocal Documents]# sort -t":" -k3 ./names.txt | cut -d ":" -f3
uniq -c | sort -n
|
1 100
1 108
1 201
1 203
1 204
1 205
1 206
1 301
1 304
1 404
1 405
1 501
1 504
1 602
1 603
1 608
1 702
1 902
2 101
2 102
2 305
2 901
2 903
3 403
[root@centosLocal Documents]#
```
