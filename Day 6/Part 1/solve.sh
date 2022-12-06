#!/bin/env -S awk -f
{
    for (i = 4; i < length($0); i++) {
        packet = substr($0, i-4, 4);
        delete seen;
        split(packet, chars, "");
        for (j = 1; j <= 4; j++) {
            if (!seen[chars[j]]) {
                seen[chars[j]] = true;
            }
        }
        if (length(seen) == 4) {
            position = i;
            break;
        }
    }
}
END{
    print(position-1)
}