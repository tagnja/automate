# Shell Errors Fix

### line 1: $' :\r': command not found”?

You have Windows-style line endings.

The no-op command `:` is instead read as `:<carriage return>`, displayed as `:\r` or more fully as `$':\r'`.

Method 1

```shell
$ dos2unix scriptname
```

Method 2

```shell
$ vi scriptname
:%s/\r$//
:x
```



References

[Why am I getting “line 1: $' :\r': command not found”?](https://unix.stackexchange.com/questions/391223/why-am-i-getting-line-1-r-command-not-found)