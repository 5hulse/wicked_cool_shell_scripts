#!/bin/bash

validAlphaNum()
{
    validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

    if [ "$validchars" = "$1" ] ; then
        return 0
    else
        return 1
    fi
}

if [ "$BASH_SOURCE" = "$0" ] ; then
    /bin/echo -n "Enter Input: "
    read input

    if ! validAlphaNum "$input" ; then
        echo "Please enter only letters and numbers." >&2
        exit 1
    else
        echo "Input is valid."
    fi
fi

exit 0
