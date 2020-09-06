# The Style Guide for Python Code

[PEP 8](https://pep8.org/) — the Style Guide for Python Code

## Tools

**Passive: show style errors**

A popular linter that comments on the style of your code in relation to the *PEP 8* specification is `flake8`.

You can install flake8 using pip:
```shell
$ pip install flake8
```

You can then run flake8 over a single file, a folder, or a pattern:

```shell
$ flake8 test.py
test.py:6:1: E302 expected 2 blank lines, found 1
test.py:23:1: E305 expected 2 blank lines after class or function definition, found 1
test.py:24:20: W292 no newline at end of file
```

**Aggressive: Code formatters will change your code automatically**

`flake8` is a passive linter: it recommends changes, but you have to go and change the code. A more aggressive approach
is a code formatter. Code formatters will change your code automatically to meet a collection of style and layout
practices.

`black` is a very unforgiving formatter. It doesn’t have any configuration options, and it has a very specific
style. This makes it great as a drop-in tool to put in your test pipeline.

> Note: black requires Python 3.6+.

You can install black via pip:

```shell
$ pip install black
```
Then to run black at the command line, provide the file or directory you want to format:

```shell
$ black test.py
```

# References

- https://realpython.com/python-testing/
