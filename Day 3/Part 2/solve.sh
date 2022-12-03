#!/bin/env -S awk -f
BEGIN{
    priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

}
function checkRucksack(rucksack) {
    if (index(rucksack, chars[i])) {
        items[chars[i]]++;
    } else {
        delete chars[i];
    }
}
{
    rucksack1 = $0; getline; 
    rucksack2 = $0; getline; 
    rucksack3 = $0;

    delete items
    split(priorities, chars, "");
    for (i = 1; i <= length(priorities); i++) {
        checkRucksack(rucksack1);
        checkRucksack(rucksack2);
        checkRucksack(rucksack3);
    }

    for (val in items) {
        if (items[val] == 3) total+= index(priorities, val);
    }
}
END{
    print(total)
}