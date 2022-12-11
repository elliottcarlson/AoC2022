#!/bin/env -S awk -f
{
    for (i = 14; i < length($0); i++) {
        packet = substr($0, i-14, 14);
        delete seen;
        split(packet, chars, "");
        for (j = 1; j <= 14; j++) {
            if (!seen[chars[j]]) {
                seen[chars[j]] = true;
            }
        }
        if (length(seen) == 14) {
            position = i;
            break;
        }
    }
}
END{
    print(position-1)
}