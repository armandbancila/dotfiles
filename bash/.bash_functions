# extract common archive formats
extract() {
    if [ -f "$*" ] ; then
        case "$*" in
            *.tar.bz2) tar xvjf "$*";;
            *.tar.gz)  tar xvzf "$*";;
            *.tar)     tar xvf "$*";;
            *.tbz2)    tar xvjf "$*";;
            *.tgz)     tar xvzf "$*";;
            *.bz2)     bunzip2 "$*";;
            *.rar)     unrar x "$*";;
            *.gz)      gunzip "$*";;
            *.zip)     unzip "$*";;
            *.Z)       uncompress "$*";;
            *.7z)      7za x "$*";;
            *)         echo "Unrecognized extension: '$*'...";;
        esac
    else
        echo "Invalid file: '$*'"
    fi
}

# roll an n-sided dice
roll() {
    python -c "import random; print(random.randint(${2:-1}, ${1:-6}))"
}

# take notes, move to dir, pull then push and take a filename as parameter
# if filename param is present, append timestamp to file and open it in vim
tn() {
    cd $HOME/Documents/text/notes
    ./sync.sh
    printf '%s\n' $'\n'"# Wrriten on $(date --rfc-email) ($(date +%s))."$'\n' >> temp
    vim "+ normal G$" +startinsert temp
}

# return number of jobs
# used in PS1
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}
