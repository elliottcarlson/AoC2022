# [AoC 2021 - Day 2: Rock Paper Scissors - Part 1](https://adventofcode.com/2022/day/2)

Run
---

```
❯ ./solve.sh ../input.txt
```


Benchmark (Actual input data)
-----------------------------

```
❯ perf stat -r 10 -d ./solve.sh ../input.txt
...
0.010090 +- 0.000289 seconds time elapsed  ( +-  2.86% )
```


Bonus Perl Golf
---------------

```
perl -pe"y/ABCXYZ/012123/;/ /;$\+=$'+3*(($'-$\`)%3)}{" ../input.txt
```

Using `perl -p` will wrap the entire statement in `while (<>) { ...; print }`. By using `}{` at the end of the Perl statement, it will only perform the final print at the end of the while loop. The code that will be interpreted now looks like:

```
while (<>) { y/ABCXYZ/012123/;/ /;$\+=$'+3*(($'-$\`)%3)}{ print }
```

There are various special variables in Perl that we can abuse to make the code as small as possible.

`$_` is the default input and pattern-searching space; i.e. for each loop through the input of the while loop, the value of the iteration will be set as the value of `$_`. Another perk is that the default input is generally the default variable used when missing from a command or operation in Perl; so while we are not using `$_` directly in this code,
the `y//` operation and the subsequent `/ /` regex will utilize `$_` without needing to include it.

`$\` is the Output Record Separator for the print operator, which is by default undefined. When set, using a print function will terminate the string with the ORS. For example, setting `$\` to "\n" will automatically add a new line character at the end of each print function call without needing to specify it each time; or, you could set it to "," and automatically have comma separated values. We can also abuse this as the output variable, so that print will automatically output the value stored in it. In this case, we will use it to store the highest encountered value during the loop.

`$` ` `  is the prematch variable. When using a regular expression to match content, the prematch variable will contain anything prior to the match. For example; if we had the string "abc" and we performed a `/b/` match,  

So now we can split the Perl statement in to two parts; first, we have the if block:

```
$\=$l,if$l>$\;
```

Here we are using the compound statements feature of Perl. The above code is the equivelant of writing `if ($l>$\) { $\=$l }`. So here we are checking if `$l` if greater than `$\`, if it is, then set `$\` to `$l`. This will always set the output value stored in `$\` to be the highest occurance of `$l`. Since `$l` is not defined initially, it will initialize as 0.

Now, in the second part of the statement, we have the logic to set the value of `$l`:

```
$l=$_==$/?0:$l+$_
```

This is a simply ternary, that checks if the current line in `$_` is equal to the newline value of `$/`; if it is, then reset the value of `$l` to 0, and if not, set the value of `$l` to be `$l` + the value of the current line in `$_`.

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

Bonus Benchmark (Actual input data)
-----------------------------------

```
❯ perf stat -r 10 -d perl -pe"y/ABCXYZ/012123/;/ /;$\+=$'+3*(($'-$\`)%3)}{" ../input.txt
...
0.004744 +- 0.000138 seconds time elapsed  ( +-  2.91% )
```
