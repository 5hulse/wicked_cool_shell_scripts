#!/bin/bash

. validint

validfloat()
{
    fvalue="$1"

    # Check if fvalue has a decimal point
    if [ ! -z $(echo $fvalue | sed 's/[^.]//g') ] ; then
        decimalPart="$(echo $fvalue | cut -d. -f1)"
        fractionalPart="${fvalue#*\.}"

        # Test decimal part
        if [ ! -z $decimalPart ] ; then
            if ! validint "$decimalPart" "" "" ; then
                return 1
            fi
        fi

        # Test fractional part
        # Ensure there is no negative sign at the front
        if [ "${fractionalPart%${fractionalPart#?}}" = "-" ] ; then
            echo "Invlid floating-point number" >&2
            return 1
        fi
        if [ "$fractionalPart" != "" ] ; then
            if ! validint "$fractionalPart" "0" "" ; then
                return 1
            fi
        fi
    
    else
        if [ "$fvalue" = "-" ] ; then
            echo "Invlid floating-point number" >&2
            return 1
        fi
        if ! validint "$fvalue" "" "" ; then
            return 1
        fi
    fi

    return 0
}

if [ "$BASH_SOURCE" = "$0" ] ; then
    
    if validfloat $1 ; then 
        echo "$1 is a valid floating-point value."
    fi

    exit 0

fi
