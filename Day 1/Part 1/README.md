# [AoC 2021 - Day 1: Calorie Counting - Part 1](https://adventofcode.com/2022/day/1)

Run
---

```
❯ ./solve.sh input.txt
```


Benchmark (Actual input data)
-----------------------------

```
❯ perf stat -r 10 -d go ./solve.sh input.txt
...
0.03558 +- 0.00245 seconds time elapsed  ( +-  6.88% )
```


Bonus
-----
I was again nerd sniped in to writing this as compact as possible in Perl:

```
perl -pe'($\=$l),if$_==$/&&$l>$\;$l=$_==$/?0:$l+$_}{'<input.txt
```

1) Using `perl -p` will wrap the entire statement in `while (<>) { ...; print }`. By using `}{` at the end of the Perl statement, it will only perform the final print at the end of the while loop.
2) We use `$\` to store the highest value encountered, which is used by Perl as the output separator, and will automatically be used in the final `print` statement.
3) At the start of the statement (`($\=$l),if$_==$/&&$l>$\`), we start with an `if` statement, checking if the current line of the while loop, stored in `$_` is a newline break, which is the default value of `$/` (shorter than `"\n"`), and if the last value (stored in `$l`, which will default to 0 when not initialized) is greater than the last highest value encountered in `$\`. If this is true, we set `$\` to `$l`.
4) Then, in the last part (`$l=$_==$/?0:$l+$_`), we set the value of `$l`; if the current line of the input file stored in `$_` is a newline (again using `$/`), then we reset the `$l` value to 0; otherwise, we add the current value in `$_` to `$l`.

Expanded pseudo code:
```
$last = 0;
$highest = 0;
while (<INPUT>) {
    $line = $_;
    if ($line == "\n" && $last > $highest) {
        $highest = $last
    }

    if ($line == "\n") {
        $last = 0;
    } else {
        $last = $last + $line;
    }
}
print $highest;
```