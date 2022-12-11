#!/bin/env bash
awk '{t+=$1} $0=='\n'&&NR>1{print t; t=0} END{print t}' $1 | sort -nr | head -n 1
