#!/usr/bin/awk -f
@include "../../aoc.awk";
BEGIN {
    tx = ty = 0;
}
/R/ { sx++; }
/L/ { sx--; }
/U/ { sy--; }
/D/ { sy++; }
{
    while ($2--) {
        hx += sx;
        hy += sy;
        dx = hx - tx;
        dy = hy - ty;
        if (abs(dx) >  1) {
            tx += sx;
            if (dy > 0) ++ty;
            else if (dy < 0) --ty;
        }
        if (abs(dy) >  1) {
            ty += sy;
            if (dx > 0) ++tx;
            else if (dx < 0) --tx;
        }
        visited[tx, ty] = 1;
    }
    sx = sy = 0;
}
END {
    for (k in visited) total += visited[k];
    print total;
}