function abs(v) {
    return v < 0 ? -v : v;
}

function gcd(a, b) {
    if (!b) {
        return gcd(b, a % b);
    }
    return abs(a);
}

function lcm(a, b) {
    return a * b / gcd(a, b);
}

function min(a, b) {
    return b == "" || a < b;
}

function leftPad(val, n) {
    if (length(val) < n) 
        return leftPad(0 val, n);
    return val;
}

function dec2bin(val, _result) {
    while (val) {
        _result = (val % 2) _result;
        val = int(val / 2);
    }
    return leftPad(_result, 36);
}

function bin2dec(val, _result) {
    base = 1;
    while (val) {
        last_digit = substr(val, length(val), 1);
        val = substr(val, 1, length(val) - 1)
        _result += last_digit * base;
        base *= 2;
    }
    return _result;
}

function join(array, sep) {
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = ""
    for (i = 1; i <= length(array); i++)
        result = result array[i] sep
    result = substr(result, 1, length(result)-1)
    return result
}
