#!/bin/bash

# Perbaikan Panjang Password tidak bisa lebih dari 50
# Makasih sudah baca notice ini :) 

r='\033[0;31m' # red
g='\033[0;32m' # green
n='\033[0m' # no color

show_usage() {
    echo "usage: $0 [ options ]"
    echo "-h, --help [ show help message ]"
    echo "-i, --information [ show information tools ]"
}

show_help() {
    clear
    echo "usage: $0 [ options ]"
    echo "-p [ password length max 50 ]"
    echo "-u [ use uppercase ]"
    echo "-l [ use lowercase ]"
    echo "-n [ use numbers ]"
    echo "-s [ use symbols ]"
    echo "-ac [ use all characters ]"
    echo "bash sgp.sh -p 10 -u use -l use -s use -n use -ac use"
}

show_information() {
    clear
    cowsay SGP
    echo "name: Secure Generator Password (sgp)"
    echo "version: 1.0.0"
    echo "author: msverse.site"
    echo "homepage: https://www.msverse.site"   
}

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -p)
        LENGTH="$2"
        if [[ $LENGTH -gt 50 ]]; then
            LENGTH=50
        fi
        shift
        shift
        ;;
        -u)
        USE_UPPERCASE="use"
        shift
        ;;
        -l)
        USE_LOWERCASE="use"
        shift
        ;;
        -n)
        USE_NUMBERS="use"
        shift
        ;;
        -s)
        USE_SYMBOLS="use"
        shift
        ;;
        -ac)
        USE_ALLCHARS="use"
        shift
        ;;
        -h|--help)
        show_help        
        exit 0
        ;;
        -i|--information)
        show_information
        exit 0
        ;;
        *)
        shift
        ;;
    esac
done

if [[ -z $LENGTH ]]; then
    LENGTH=16
fi

CHARACTERS=""

if [[ $USE_UPPERCASE == "use" ]]; then
    CHARACTERS+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
fi

if [[ $USE_LOWERCASE == "use" ]]; then
    CHARACTERS+="abcdefghijklmnopqrstuvwxyz"
fi

if [[ $USE_NUMBERS == "use" ]]; then
    CHARACTERS+="0123456789"
fi

if [[ $USE_SYMBOLS == "use" ]]; then
    CHARACTERS+="!@#$%^&*()-=_+[]{}|;:,.<>?/~"
fi

if [[ $USE_ALLCHARS == "use" ]]; then
    CHARACTERS+="!@#$%^&*()-=_+[]{}|;:,.<>?/~ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
fi

if [[ -z $CHARACTERS ]]; then
    cowsay SGP
    show_usage
    exit 1
fi

for i in {1..5}; do
    PASSWORD=$(tr -dc "$CHARACTERS" < /dev/urandom | head -c "$LENGTH")
    echo -e "${r}[${g} $PASSWORD ${r}]${n}"
done
