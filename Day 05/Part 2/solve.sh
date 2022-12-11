#!/bin/env -S awk -f
BEGIN {
    getline;
    columns = length($0) / 4;
    row = 1;
    while (length($0) != 1) {
        split($0, chars, "");
        if (chars[2] ~ /^[0-9]/) break;
        column = 1;
        for (i = 2; i <= length($0); i += 4) {
            if (chars[i] != " ") {
                data[column] = sprintf("%s%s", data[column], chars[i]);
            }
            column++;
        }
        getline;
    }
    getline;
}
{
    data[int($6)] = sprintf("%s%s", substr(data[int($4)],1,$2), data[int($6)])
    data[int($4)] = substr(data[int($4)],$2+1)
}
END{
    for (x = 1; x <= columns; x++) {
        printf("%s", substr(data[x],1,1));
    }
    printf("\n")
}