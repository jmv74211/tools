# sed

**sed** is a complex utility to master. This command streams the editor for filtering and transforming text. Entire books have been written dedicated to using sed proficiently. So please keep in mind, this tutorial has a purpose of introducing three basic-common-uses of sed −

- character substitution
- printing operations
- delete operations

The common command syntax for sed is −

```
sed [options] [file to operate on]
```

Following are the common sed switches to remember.

| Switch | Action |
|-----|--------|
| -i | Edit files in place instead of stream, -i[SUFFIX] to create backup file |
| -e | Add the script commands to be executed |
| -n | Quiet, suppress automatic printing |
| -r | ReGex, use extended regular expressions in the script |

**-i** will apply changes to a file, instead of editing the file's stream as passed to sed.

sed, when used with the **-e** option extends the command to process multiple operations on a stream. This can be done instead piping sed recursively.

```
echo "Windows and IIS run the Internet" | sed -e 's/Windows/Linux/' -e 's/ and           
IIS//'  -e 's/run/runs/'
Linux runs the Internet
```
The **-n** option with sed suppresses default printing to stdout. Using sed's print command, as we see, each line will be duplicated to stdout.

```
bash-3.2# sed 'p' ./lines.txt  
line1
line1
line2
line2
```

This time, we use the -n option with sed −

```
bash-3.2# sed -n 'p' ./lines.txt  
line1
line2
```

sed will send content streams to stdout. When the *'p'* or print command is added, a separate stream is sent for each line causing all lines to be duplicated in stdout.

### sed substitution command

This command is specified with the **'s'** option. We have seen sed used with its substitution command a few times already. Following is a simple example −


> **Note:** If we want to edit a file using sed command, we have to use `-i` parameter

Print `test_file.txt` content:

```
jmv74211@Jonathan ~/Desktop/trash $ cat test_file.txt
This is my line 1
This is an example test. This line will be modified to do a little test
```

**Replace one occurrence per line**

We can replace "This" word to "Here":

```
jmv74211@Jonathan ~/Desktop/trash $ sed "s/This/Here/" ./test_file.txt
Here is my line 1
Here is an example test. This line will be modified to do a little test
```

**Replace all occurrences of a line**

As can be seen, only the first occurrence of each line has been modified. In case you want to modify all the occurrences of the line we must use `/g`

```
jmv74211@Jonathan ~/Desktop/trash $ sed "s/This/Here/g" ./test_file.txt
Here is my line 1
Here is an example test. Here line will be modified to do a little test
```

**Use of regular expressions**

**sed** also accepts regular expressions:

```
jmv74211@Jonathan ~/Desktop/trash $ sed "s/^This is my //g" ./test_file.txt
line 1
This is an example test. This line will be modified to do a little test

```

**Concatenate replacements**

```
jmv74211@Jonathan ~/Desktop/trash $ sed "s/line/example/g; s/This example .*//g" ./test_file.txt
This is my example 1
This is an example test.
```

**Delete occurrences**

We can delete occurences lines with **`d`** command as follows:

```
jmv74211@Jonathan ~/Desktop/trash $ sed "/^This is an/ d" ./test_file.txt
This is my line 1

```

### sed print command

This command is specified with the *'p'* command.

Let's use our names.txt file, the output has been edited for brevity sake −

```
[root@centosLocal Documents]# sed -n "p" ./names.txt  
Ted:Daniel:101
Jenny:Colon:608
Dana:Maxwell:602
Marian:Little:903
Bobbie:Chapman:403
Nicolas:Singleton:203
Dale:Barton:901
Aaron:Dennis:305
```

sed allows the use of "addresses", to more granularly define what is being printed to stdout −

```
[root@centosLocal Documents]# sed -n "1,10p" ./names.txt
Ted:Daniel:101
Jenny:Colon:608
Dana:Maxwell:602
Marian:Little:903
Bobbie:Chapman:403
Nicolas:Singleton:203
Dale:Barton:901
Aaron:Dennis:305
Santos:Andrews:504
Jacqueline:Neal:102
[root@centosLocal Documents]#
```

Just like head, we printed the first 10 lines of our names.txt file.

What if we only wanted to print out those with an office on the 9th floor?

```
[root@centosLocal Documents]# sed -n "/90/p" ./names.txt
Marian:Little:903
Dale:Barton:901
Kellie:Curtis:903:
Gina:Carr:902
Antonia:Lucas:901
[root@centosLocal Documents]#
```

Pretty easy. We can also print out everyone, except those with offices on the 9th floor −

```
[root@centosLocal Documents]# sed -n '/90/ !p' ./names.txt
Ted:Daniel:101
Jenny:Colon:608
Dana:Maxwell:602
Bobbie:Chapman:403
Nicolas:Singleton:203
Aaron:Dennis:305
Santos:Andrews:504
Jacqueline:Neal:102
Billy:Crawford:301
Rosa:Summers:405
Matt:Davis:305
Francisco:Gilbert:101
Sidney:Mac:100
Heidi:Simmons:204
Matt:Davis:205
Cristina:Torres:206
Sonya:Weaver:403
Donald:Evans:403
```
In the above code, we negated *'p'* printing operation between / and /with !. This performs similarly to the the "d" or delete command. However, the results can vary with negation in sed. So as a general rule: p to print and negate what you do not want.

### sed delete command

As mentioned, the delete command is the opposite of the sed print command. Let's start with our name.txt file −

```
[root@centosLocal Documents]# sed 'd' ./names.txt  
[root@centosLocal Documents]#
```

Nothing printed out. With the above command, we asked sed to delete every line from stdout in the stream. Now, let's only print the first two lines and "delete" the rest of the stream −

```
[root@centosLocal Documents]# sed '1,2 !d' ./names.txt  
Ted:Daniel:101
Jenny:Colon:608
[root@centosLocal Documents]#
```

See? Similar to the 'p', or print command. Now let's do something useful with the delete command. Say we want to remove all blank lines in a file −

```
[root@centosLocal Documents]# cat lines.txt  
line1
line2
line3
line4
line5
[root@centosLocal Documents]#
```

It is not uncommon to receive a file like this containing jumbled text, from copying and pasting an email or formatted with non-standard line breaks. Instead of interactively editing the file in vim, we can use sed to do the work for us.

```
[root@centosLocal Documents]# sed -i '/^\s*$/ d' ./lines.txt
[root@centosLocal Documents]# cat ./lines.txt  
line1
line2
line3
line4
line5
[root@centosLocal Documents]#
```
The file is now formatted in an easily readable fashion.

> **Note** − When making changes to the important files, use -iswitch. Appending a file backup suffix is greatly advised to reserve the file contents (sed can make some extreme changes with the slightest typo).
