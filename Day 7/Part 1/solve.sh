#!/bin/env -S awk -f
BEGIN{
    path = "/";
    fs[path] = 0;
}
{
    sub("\r", "", $2);
    if ($1 == "$") {
        if ($2 == "cd") {
            sub("\r", "", $3);
            switch ($3) {
                case "/":
                    path = "/";
                    break;
                case "..":
                    cmd = "dirname " path
                    cmd | getline path
                    close(cmd)
                    break;
                default:
                    if (path == "/") {
                        path = sprintf("/%s", $3)
                    } else {
                        path = sprintf("%s/%s", path, $3)
                    }
                    break;
            }
        }
    } else {
        if ($1 == "dir") next;
        cwd = path;
        do {
            fs[cwd]+=$1;
            if (cwd == "/") {
                break;
            }
            cmd = "dirname " cwd
            cmd | getline cwd
            close(cmd)
        } while(1)
    }
}
END{
    printf("Total directories: %s\n", length(fs));
    under100k=0;
    for (x in fs) {
        printf("Dir: %s, Size: %d\n", x, fs[x]);
        if (fs[x]<100000) {
            under100k+=fs[x];
        }
    }
    printf("Solution: %d\n", under100k)
}