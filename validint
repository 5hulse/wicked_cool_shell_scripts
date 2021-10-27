#!/bin/bash

validint()
{
    # Validate the first field is an integer,
    # and ensure that the it lies within the
    # range $2 <= $1 <= $3

    number="$1"
    min="$2"
    max="$3"

    if [ -z $number ] ; then
        echo "You didn't enter anything. PLease enter a number." >&2
        return 1
    fi

    if [ "${number%${number#?}}" = "-" ] ; then
        testvalue="${number#?}" # Grab all but first character
    else
        testvalue="$number"
    fi

    nodigits="$(echo $testvalue | sed 's/[[:digit:]]//g')"

    if [ ! -z $nodigits ] ; then
        echo "Invalid number format." >&2
        return 1
    fi

    if [ ! -z $min ] ; then
        if [ "$number" -lt "$min" ] ; then
            echo "Value is too small: smallest acceptable number is $min" >&2
            return 1
        fi
    fi

    if [ ! -z $max ] ; then
        if [ "$number" -gt "$max" ] ; then
            echo "Value is too large: greatest acceptable number is $max" >&2
            return 1
        fi
    fi
    
    return 0
}

if [ "$BASH_SOURCE" = "$0" ] ; then

    if validint "$1" "$2" "$3" ; then
        echo "Input is a valid integer within your constraints."
    fi

fi
