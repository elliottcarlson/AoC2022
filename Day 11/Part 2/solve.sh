#!/bin/env -S awk -f
@include "../../aoc.awk";
function worry(monkey, old) {
    val = modifier[monkey] == "old" ? old : int(modifier[monkey])
    switch(operation[monkey]) {
        case "+":
            return old + val;
        case "*":
            return old * val;    
    }
}
BEGIN{
    divproduct = 1
}
{
    sub("\r", "", $0);
}
/Monkey/ {
    monkey = int(gensub(/Monkey ([0-9]+):/, "\\1", "g", $0))
    monkies++;
}
/Starting items:/ {
    split($0, parts, ": ")
    split(parts[2], list, ", ")
    items[monkey] = join(list, ",")
}
/Operation:/ {
    split($0, parts, "new = old ")
    split(parts[2], op, " ")
    operation[monkey] = op[1]
    modifier[monkey] = op[2]
}
/Test:/ {
    test[monkey] = int(gensub(/Test: divisible by ([0-9]+)/, "\\1", "g", $0))
    divproduct *= test[monkey];
}
/If true:/ {
    truthy[monkey] = int(gensub(/If true: throw to monkey ([0-9]+)/, "\\1", "g", $0))
}
/If false:/ {
    falsy[monkey] = int(gensub(/If false: throw to monkey ([0-9]+)/, "\\1", "g", $0))
}
END {
    for (;r++<10000;) {
        for (monkey = 0; monkey < monkies; monkey++) {
            split(items[monkey], inspecting, ",")
            for (current in inspecting) {
                inspected[monkey]++;
                new = worry(monkey, inspecting[current])
                new = new % divproduct
                new = sprintf("%0.f", new - 0.49)
                if (new % test[monkey] == 0) {
                    target = truthy[monkey]
                } else {
                    target = falsy[monkey]
                }
                items[monkey] = ""
                items[target] = items[target] (length(items[target]) > 0 ? "," : "") new
            }
        }
    }
    cnt = asort(inspected, sorted)
    print(sorted[cnt] * sorted[cnt-1])
}