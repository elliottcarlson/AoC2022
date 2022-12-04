#!/bin/env -S awk -f
BEGIN {
    FS = ",|-"
}
{
    if (($1 >= $3 && $2 <= $4) || ($3 >= $1 && $4 <= $2)) {
        total += 1;
    }
}
END{
    print(total)
}