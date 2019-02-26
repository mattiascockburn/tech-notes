= aspell tips

== Convert aspell dict into wordlist

First, extract the dict into a simple wordlist.
Here i am using the spanish dict (es)

```
aspell -d es dump master | aspell -l es expand >/tmp/foobar.txt
```

Now, convert it so there is only one line per word and sort it lexicographically:

```
for a in $(cat /tmp/foobar.txt); do echo $a >>/tmp/split;done; sort -ud -o /tmp/my_es_dict.txt /tmp/split
```

The resulting file `/tmp/my_es_dict.txt` now may be used like a `words` file. I am using it in neovim as a dictionary.

=== Without tempfiles

Slicker version of the above:

```
aspell -d es dump master | aspell -l es expand | tr ' ' '\n' | sort -ud -o /tmp/my_es_dict.txt
```
