#!/bin/bash

# Expects DD and TD  to be instantiated.
nicenumber()
{
    integer=$(echo $1 | cut -d. -f1)
    decimal=$(echo $1 | cut -d. -f2)

    if [ "$decimal" != "$1" ] ; then
        # Include fractional part
        result="${DD:='.'}$decimal"
    fi
    
    thousands=$integer

    while [ $thousands -gt 999 ] ; do
        remainder=$(($thousands % 1000))

        while [ ${#remainder} -lt 3 ] ; do
            remainder="0$remainder"
        done

        result="${TD:=","}${remainder}${result}"
        thousands=$(($thousands / 1000))
    done

    nicenum="${thousands}${result}"

    if [ ! -z $2 ] ; then
        echo $nicenum
    fi
}

DD="."
TD=","

if [ "$BASH_SOURCE" = "$0" ] ; then
    while getopts "d:t:" opt; do
        case $opt in
            d ) DD="$OPTARG"  ;;
            t ) TD="$OPTARG"  ;;
        esac
    done
    shift $(($OPTIND - 1))
    
    if [ $# -eq 0 ] ; then
        echo "Usage: $(basename $0) [-d c] [-t c] number"
        echo "   -d specifies the decimal point delimiter"
        echo "   -t specifies the thousands delimiter"
        exit 0
    fi

nicenumber $1 1

exit 0

fi
