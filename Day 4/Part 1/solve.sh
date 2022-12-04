#!/bin/env -S awk -f
{
    split($0, pairs, ",");
    split(pairs[1], range1, "-")
    split(pairs[2], range2, "-")
    if ((range1[1] >= range2[1] && range1[2] <= range2[2]) || (range2[1] >= range1[1] && range2[2] <= range1[2])) {
        total += 1;
    }
}
END{
    print(total)
}