# more and less

Both **more** and **less** commands allow pagination of large text files. When perusing large files, it is not always possible to use grep unless we know an exact string to search. So we would want to use either more or less.

Typically, less is the preferred choice, as it allows both forward and backward perusal of paginated text. However, less may not be available on default installations of older Linux distributions and even some modern Unix operating systems.

> Usually less is preferred, because less really offers more than more.

As shown above, when invoked less opens into a new buffer separate from the shell
prompt. When trying less, it sometimes may give an error as follows:

```
bash: less: command not found...
```

Either use more or install less from the source of the package manager. But less should be included on all modern Linux Distributions and even ported to Unix platforms. Some will even **symlink** more to less.
