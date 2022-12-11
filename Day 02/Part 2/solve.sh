#!/bin/env -S awk -f
{
    gsub("[A|X]",1);
    gsub("[B|Y]",2);
    gsub("[C|Z]",3);
    total += $2 == 2 ? 3 + $1 : $2 == 3 ? 6 + (($1 + 1) > 3 ? 1 : $1 + 1) : (($1 - 1) > 0 ? $1 - 1 : 3)
}
END{
    print total
}