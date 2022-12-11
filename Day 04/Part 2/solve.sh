#!/bin/env -S awk -f
BEGIN {
    FS = ",|-"
}
{
    if ($1 <= $4 && $3 <= $2) {
        total += 1;
    }
}
END{
    print(total)
}