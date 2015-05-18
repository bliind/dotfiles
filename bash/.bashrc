export TERM=xterm-256color
export PROMPT_COMMAND='case $? in 0) color1=$(tput setaf 120);color2=$(tput setaf 118);color3=$(tput setaf 46);; 130) color1=$(tput setaf 190);color2=$(tput setaf 184);color3=$(tput setaf 178);; *) color1=$(tput bold;tput setaf 9);color2=$(tput bold;tput setaf 196);color3=$(tput bold;tput setaf 196);;esac'
export PS1='[\[${color1}\]\t\[${reset}\]] [\[${color2}\]$?\[${reset}\]] \[${color3}\]\h:\[${reset}${color1}\]\w\$\[${reset}\] '
export PS4='+ $BASH_SOURCE:$FUNCNAME:$LINENO:'
export reset=$(tput sgr0)

#####################################################################################
#                                     Aliases                                       #
#####################################################################################
alias sh="PS1='\$ ' sh"
alias ksh="PS1='\$ ' ksh"
alias curl="curl -A 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36'"

#####################################################################################
#                                    Functions                                      #
#####################################################################################
gimme() {
    sudo apt-get install "$@"
}

sprunge() {
    curl -F 'sprunge=<-' http://sprunge.us
}

ixio() {
    curl -F 'f:1=<-' http://ix.io
}

colors() {
    for ((i=0;i<256;i++)); do
        if (( ${#i} != 1 && ${i#${i%?}} == 0 )); then
            printf "\n"
        fi
        tput setaf $i
        printf "%5s" "$i "
        tput bold
        printf "%5s" "$i "
        tput sgr0
    done
    printf "\n"
}

getLatLon() {
    geoAddress="$1"
    webService="http://maps.google.com/maps/api/geocode/xml?address=${geoAddress}&sensor=false"
    latitude=$(curl -s -S "$webService" | xmlstarlet sel -t -m "/GeocodeResponse/result[1]/geometry/location" -v lat)
    longitude=$(curl -s -S "$webService" | xmlstarlet sel -t -m "/GeocodeResponse/result[1]/geometry/location" -v lng)
}

latest() {
    local file latest
    for file in "${1:-.}"/*; do
        [[ $file -nt $latest ]] && latest=$file
    done
    printf '%s\n' "$latest"
}

oldest() {
    local file oldest
    for file in "${1:-.}"/*; do
        [[ $file -ot $oldest ]] && oldest=$file
    done
    printf '%s\n' "$oldest" 
}

clear() {
    /usr/bin/clear;
    tput cup $LINES 0;
}

imgit() {
    curl -F "name=@$1" http://img.vim-cn.com/
}

title() {
    echo -en "\e]0;${1}\a"
}

winID() {
    xwininfo | awk '/Window id/{print$4}'
}

#####################################################################################
#                                  Everything Else                                  #
#####################################################################################

#[[ ! $TMUX ]] && tmux
if [[ -t 0 ]]; then
    tput cup $LINES 0
    sf -A tux
fi
