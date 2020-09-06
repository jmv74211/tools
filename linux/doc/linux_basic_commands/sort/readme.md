# sort

**sort** has several optimizations for sorting based on datatypes. Theis command writes
sorted concatenation of all files to standard output. However, be weary, complex sort
operations on large files of a few GigaBytes can impede the system performance.

When running a production server with limited CPU and/or memory availability, it is
recommended to offload these larger files to a workstation for sorting operations during
peak business hours.

| Switch | Action |
|-----|--------|
| -b | Ignore leading blank lines |
| -d | Dictionary order, consider only blanks and alphanumeric characters |
| -f | Ignore case, folding lower and upper characters |
| -g | General numeric sort |
| -M | Month sort |
| -h | Human readable numeric sort 1KB, 1MB, 1GB |
| -R | Random sort |
| -m | Merge already sorted files |

Feel free to copy the tabular text below and follow along with our sort examples. Be sure
each column is separated with a tab character.

| first name | last name | office |
|-----|--------|--------|
|Ted| Daniel| 101|
|Jenny| Colon| 608|
|Dana| Maxwell| 602|
|Marian| Little| 903|
Nicolas| Singleton| 203|
|Bobbie| Chapman| 403|
|Dale| Barton| 901|
|Aaron| Dennis| 305|
|Santos| Andrews| 504|
|Jacqueline| Neal| 102|
|Billy| Crawford| 301|
|Rosa| Summers| 405|
|Kellie| Curtis| 903|
|Matt| Davis| 305|
|Gina| Carr| 902|
|Francisco| Gilbert| 101|
|Sidney| Mack| 901|
|Heidi| Simmons| 204|
|Cristina| Torres| 206|
|Sonya| Weaver| 403|
|Donald| Evans| 403|
|Gwendolyn| Chambers| 108|
|Antonia| Lucas| 901|
|Blanche| Hayes| 603|
|Carrie| Todd| 201|
|Terence| Anderson| 501|
|Joan| Parsons| 102|
|Rose| Fisher| 304|
|Malcolm| Matthews| 702|

Using **sort** in its most basic, default form:

```
[root@centosLocal centos]# sort ./Documents/names.txt
Aaron Dennis 305
Antonia Lucas 901
Billy Crawford 301
Blanche Hayes 603
Bobbie Chapman 403
Carrie Todd 201
Cristina Torres 206
Dale Barton 901
Dana Maxwell 602
Donald Evans 403
...
```

Sometimes, we will want to sort files on another column, other than the first column. A sort can be applied to other columns with the **-t** and **-k** switches.

```
`-t` : define a file delimiter
`-k` : key count to sort by (think of this as a column specified from the delimiter.
`-n` : sort in numeric order
```

```
[root@centosLocal centos]# sort -t '    ' -k 3n ./Documents/names.txt
Ted Daniel 101
Francisco Gilber 101
Jacqueline Neal 102
Joan Parsons 202
...
```
