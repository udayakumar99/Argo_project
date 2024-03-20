#!/bin/bash
factorial() {
    if [ $1 -eq 0 ]; then
        echo 1
    else
        local i=$1
        local result=1
        while [ $i -gt 1 ]; do
            result=$((result * i))
            i=$((i - 1))
        done
        echo $result
    fi
}
echo "fact for 8 : $(factorial 8)"

