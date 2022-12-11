function abs(v) {
    return v < 0 ? -v : v;
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