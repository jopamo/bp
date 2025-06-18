#!/usr/bin/env bash

# Push [-c] VARNAME ARG1 ARG2 ...
#   - If "-c" is present, clear the variable first.
#   - Append each ARG... to the named variable, with safe shell quoting.
Push() {
    local var oldval newval

    if [[ $1 == -c ]]; then
        shift
        var=$1
        shift
        oldval=''
    else
        var=$1
        shift
        eval "oldval=\"\$$var\""
    fi

    if (( $# == 0 )); then
        eval "$var=\"\$oldval\""
        return
    fi

    newval=$(printf '%q ' "$@")

    newval=${newval% }

    if [[ -n "$oldval" ]]; then
        oldval="$oldval $newval"
    else
        oldval="$newval"
    fi

    eval "$var=\$oldval"
}
