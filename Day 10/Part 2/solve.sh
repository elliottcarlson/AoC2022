#!/bin/env -S awk -f
@include "../../aoc.awk";
function pixel() { return abs(x+1-cycle++%40) <= 1 ? "#" : " " }
{
    crt = crt pixel();
}
/addx/ {
    crt = crt pixel();
    x+=$2;
}
END{
    patsplit(crt, lines, /.{40}/);
    for(i in lines) print(lines[i]);
}