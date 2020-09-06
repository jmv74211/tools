# tr

**tr** is commonly used to translate or delete characters in a string. Think of tr as a simpler alternative to sed's substitute command. Reading from stdin versus a file.

Following is the syntax for tr. This command translates or deletes characters.

```
tr [OPTION] SET1 [SET2]
```

Following are the commonly used switches and character classes with tr.

```
| Switch | Action |
|-----|--------|
| -d | Delete |
| -s | Squeeze repeated text in SET1 with single occurrence in SET2|
| [:alnum:] | Alpha numeric characters |
| [:alpha:] | All letters |
| [:digit:] | All digits|
| [:blank:]| All horizontal whitespace|
| [:space:] | All horizontal or vertical whitespace |
| [:graph:] | All printable characters, not including spaces |
| [:print:] | All printable characters, including spaces |
| [:punct:] | All punctuation characters |
| [:lower:] | All lowercase characters |
| [:upper:] | All uppercase characters |
```

When thinking should one go with "use `sed`" or "use `tr`", it is better to go with keep it simple philosophy. If an operation is simple in tr; use it. However, once you start thinking about using tr recursively, it is better to use sed's substitution command.

Typically, tr will replace [SET1] with characters in [SET2] unless the -d switch is used. Then, the characters from the stream in [SET1] will be deleted.

Using tr on our names.txt file to turn all lower case caracters into uppper case −

```
[root@centosLocal Documents]# tr [:lower:] [:upper:]  < names.txt  
TED:DANIEL:101
JENNY:COLON:608
DANA:MAXWELL:602
MARIAN:LITTLE:903
BOBBIE:CHAPMAN:403
NICOLAS:SINGLETON:203
DALE:BARTON:901
AARON:DENNIS:305
SANTOS:ANDREWS:504
JACQUELINE:NEAL:102
[root@centosLocal Documents]#
```
Let's turn the ":" character back into a Tab −

```
[root@centosLocal Documents]# tr [:]  [\\t] < names.txt  
Ted Daniel  101
Jenny   Colon     608
Dana    Maxwell    602
Marian      Little  903
Bobbie      Chapman 403
Nicolas Singleton   203
Dale    Barton  901
Aaron   Dennis  305
Santos      Andrews    504
Jacqueline  Neal    102
[root@centosLocal Documents]#
```

What if wanted to save the results? Pretty easy using redirection.

```
[root@centosLocal Documents]# tr [:]  [\\t]  < names.txt >> tabbedNames.txt
[root@centosLocal Documents]# cat tabbedNames.txt  
Ted Daniel  101
Jenny   Colon   608
Dana    Maxwell 602
Marian  Little  903
Bobbie  Chapman 403
Nicolas Singleton   203
[root@centosLocal Documents]#
```
Let's use the -s or squeeze option on poorly formatted text −

```[root@centosLocal Documents]# cat lines.txt
line 1
line     2
line  3
line                      4
line      5
[root@centosLocal Documents]# tr -s [:blank:] ' ' < lines.txt >> linesFormat.txt
[root@centosLocal Documents]# cat linesFormat.txt  
line 1
line 2
line 3
line 4
line 5
[root@centosLocal Documents]#
[root@centosLocal Documents]# cat lines.txt
line 1
line     2
line  3
line                      4
line      5
[root@centosLocal Documents]# tr -s [:blank:] ' ' < lines.txt >> linesFormat.txt
[root@centosLocal Documents]# cat linesFormat.txt  
line 1
line 2
line 3
line 4
line 5
[root@centosLocal Documents]#
```
