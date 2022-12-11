#!/usr/bin/env -S awk -f
/R/ { sx++ }
/L/ { sx-- }
/U/ { sy-- }
/D/ { sy++ }
{
    while ($2--) {
        x[0] += sx
        y[0] += sy
        for (i=1; i < 10; i++) {
            dx = x[i-1] - x[i];
            dy = y[i-1] - y[i];
            if (dx > 1) {
                ++x[i];
                if (dy > 0) ++y[i];
                else if (dy < 0) --y[i];
            } else if (dx < -1) {
                --x[i];
                if (dy > 0) ++y[i];
                else if (dy < 0) --y[i];
            } else if (dy > 1) {
                ++y[i];
                if (dx > 0) ++x[i];
                else if (dx < 0) --x[i];
            } else if (dy < -1) {
                --y[i];
                if (dx > 0) ++x[i];
                else if (dx < 0) --x[i];
            }
        }
        visited[x[9], y[9]] = 1;
    }
    sx = sy = 0;
}
END {
    for (k in visited) total += visited[k];
    print total;
}