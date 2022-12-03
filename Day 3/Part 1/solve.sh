#!/bin/env -S awk -f
BEGIN{
    priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}
{
    split($0, chars, "");
    for (i=1; i <= length($0)/2; i++) {
        if (match(substr($0, length($0)/2+1), chars[i])) {
            break;
        }
    }
    total += index(priorities, chars[i]);
}
END{
    print(total)
}