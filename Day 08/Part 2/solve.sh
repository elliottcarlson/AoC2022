#!/bin/env -S awk -f
{
    row++;
    split($0, chars, "");
    for (col = 2; col < length($0)-1; col++) {
        tree[row-1,col-1] = chars[col];
    }
}
END {
    for (x = 1; x < row; x++) {
        for (y = 1; y < row; y++) {
            up = 0;
            down = 0;
            left = 0;
            right = 0;

            for (z = x - 1; z >= 0; z--) {
                up++;
                if (tree[z,y] >= tree[x,y]) break;
            }

            for (z = x + 1; z < row; z++) {
                down++;
                if (tree[z,y] >= tree[x,y]) break;
            }

            for (z = y - 1; z >= 0; z--) {
                left++;
                if (tree[x,z] >= tree[x,y]) break;
            }

            for (z = y + 1; z < row; z++) {
                right++;
                if (tree[x,z] >= tree[x,y]) break;
            }

            score = up * down * left * right;
            if (score > highest) highest = score;
        }

    }
    print(highest)
}