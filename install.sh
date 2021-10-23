#!/bin/bash

bold="\e[1m"
underline="\e[4m"

BLACK="\e[40m"
RED="\e[41m"
GREEN="\e[42m"
ORANGE="\e[43m"
BLUE="\e[44m"
AQUA="\e[106m"
WHITE="\e[107m"

black="\e[30m"
red="\e[31m"
green="\e[32m"
orange="\e[33m"
blue="\e[34m"
white="\e[97m"
aqua="\e[96m"
darkgray="\e[90m"
gray="\e[37m"
yellow="\e[93m"
end="\e[0m"

check_sum="0532471ea1adc1ca7421c02ea29e20a5bf2b84e8" #sha1sum

function PRINT_DEPS ()
{
    while read line; do
        printf "%s\n" "$line"
    done <<-EOF

    ================================================
    
    requierd dependencies:

    mpv, bash, awk, grep, curl, sort, unzip
    uniq, imagemagic, ffmpeg, kitty, smenu
    
    ================================================

EOF
}

function ERROR ()
{
    clear
    echo -en "\n${red}Error!!${end} command not found: ${aqua}${bold}${1}${end}\n"
    PRINT_DEPS
    exit 69
}

function WARN ()
{
    clear
    echo -en "\n${orange}Warning!!${end} command not found: ${aqua}${bold}${1}${end}\n"
}

function DEPS-CHECK ()
{
    type bash &>/dev/null || ERROR "bash"
    type smenu &>/dev/null || ERROR "smenu"
    type awk &>/dev/null || ERROR "awk"
    type grep &>/dev/null || ERROR "grep"
    type curl &>/dev/null || ERROR "curl"
    type sort &>/dev/null || ERROR "sort"
    type uniq &>/dev/null || ERROR "uniq"
    type convert &>/dev/null || ERROR "imagemagic"
    type mpv &>/dev/null || ERROR "mpv"
    type ffmpeg &>/dev/null || ERROR "ffmpeg"
    type kitty &>/dev/null || ERROR "kitty"
    type unzip &>/dev/null || ERROR "unzip"
#echo -en "${green}deps-check - done"
}

function INFO ()
{
    echo "!!for thumbnail, use a terminal emulator such as kitty that does support graphics protocol"
    echo -en "${green}use ./pcli to run the script${end}\n"
}

clear
DEPS-CHECK

if [[ -f "pcli" ]]
then
    echo -en "${green}use ./pcli to run the script${end}\n"
    exit 69
fi

if [[ -f chad.jpg ]]
then
    
    [ -z "$( sha1sum chad.jpg | grep ${check_sum} )" ] && echo -en "${red}ERROR!!${end}\nchad.jpg: FAILED\nERROR: computed checksum did NOT match\n[sha1sum] <chad.jpg> (expected: ${check_sum})\n" && exit 69
    unzip chad.jpg &>/dev/null
    INFO
else
    echo -en "${red}ERROR!! ${end}cannot find or open chad.jpg"
fi
