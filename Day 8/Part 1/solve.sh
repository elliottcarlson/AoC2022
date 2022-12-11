#!/bin/env -S awk -f
{
    row++;
    split($0, chars, "");
    for (col = 1; col <= length($0); col++) {
        tree[row,col] = chars[col];
    }
}
END {
    total += 4 * row - 4;
    for (x = 2; x < row; x++) {
        for (y = 2; y < row; y++) {
            visible = 4;
            for (z = 0; z < x; z++) {
                if (tree[z,y] >= tree[x,y]) { visible--; break }
            }

            for (z = row; z > x; z--) {
                if (tree[z,y] >= tree[x,y]) { visible--; break }
            }

            for (z = 0; z < y; z++) {
                if (tree[x,z] >= tree[x,y]) { visible--; break; }
            }

            for (z = row; z > y; z--) {
                if (tree[x,z] >= tree[x,y]) { visible--; break; }
            }

            if (visible) total++;
        }

    }
    print(total)
}