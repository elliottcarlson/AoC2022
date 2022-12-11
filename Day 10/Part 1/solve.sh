#!/bin/env -S awk -f
function cycle() { count++; signal[count]=count*(x+1); }
{
    cycle();
}
/addx/ {
    cycle();
    x+=$2;
}
END {
    for(i=20; i<=220; i+=40) total+=signal[i];
    print(total);
}