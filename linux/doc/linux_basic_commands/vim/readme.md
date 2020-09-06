# vim

vim represents a newer, improved version of the vi text editor for Linux. vim is installed
by default on mostly recent Unix systems. However, some older and
minimal base installs will only include the original vi by default.
The biggest difference between vi and vim are advanced ease-of-use features such as
moving the cursor with the arrow keys. Where vim will allow the user to navigate a text
file with the arrow keys, vi is restricted to using the "`h`", "`j`", "`k`", "`l`" keys, listed as follows.

vi text document navigation:

| key | Action |
|-----|--------|
| j | Move down one line |
| k | Move up one line |
| l | Move to the left on character |
| h | Move to the right one character |

Using vim the same actions can be accomplished with the arrow keys on a standard English (and other common language) based qwerty, keyboard layout. Similarly, vi will often not
interpret the numeric keypad on as well.

Mostly, these days, vi will be symlinked to vim. If you ever find it frustrating your arrow
keys are doing things unexpected when pressed, try using your package manager to install
vim.

vim uses the concept of modes when manipulating and opening files. The two modes we will focus on are:

- *normal*: This is the mode vim uses when a file is first opened, and allows for
entering commands.
- insert: The insert mode is used to actually edit text in a file

Vim expects us to send commands for file operations. To enable line number, use the
colon key: shift+:. Your cursor will now appear at the bottom of the document. Type "set
nu" and then hit enter.

```
:set nu
```

Now, we will always know where in the file we are. This is also a necessity when
programming in vim. Yes! vim has the best syntax highlighting and can be used for making
Ruby, Perl, Python, Bash, PHP, and other scripts.
Following table lists the most common commands in normal mode.

| Command | Action |
|-----|--------|
| G | Go to the end of the file |
| gg | Go to the beginning of the file |
| x | Delete the selected character |
| u | Undo the last modifications |
| Enter | Jump forward by lines |
| dd | Delete the entire line |
| ? | Search for a string |
| / | Proceed to the next search occurrence |

We will pretend that we made edits on a critical file and want to be sure not to save any
unintended changes. Hit the shift+: and type: q!. This will exit vim, discarding any
changes made.

Now, we want to actually edit a file in vim: at the console type: vim myfile.txt
We are now looking at a blank text buffer in vim. Let's write something: say hit "i".

vim is now in insert mode, allowing us to make edits to a file just like in Notepad. Type a
few paragraphs in your buffer, whatever you want. Later, use the following steps to save
the file:

- Step 1: Press the escape key
- Step 2: Press :
- Step 3: type wq myfile.txt:w and hit Enter
