## functions
### temp
a() {
	~/scripts/swcr.sh &
	disown
	printf "\033c"
}

b() {
	pgrep "swcr.sh"
}

### batch rename images
batchrename() {
	ls | cat -n | while read n f; do mv "$f" "file$n.jpg"; done
}

### extract common archive formats
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

### take ownership of directory
seize() {
	sudo chown -R ${USER} ${1:-.}
}

### dirsize - finds directory sizes and lists them for the current directory
dirsize() {
	du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
	egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
	egrep '^ *[0-9.]*M' /tmp/list
	egrep '^ *[0-9.]*G' /tmp/list
	rm -rf /tmp/list
}

### roll an n-sided dice
roll() {
	$(python -c "import random; print(random.randint(${2:-1}, ${1:-6}))")
}

### take notes, move to dir, pull then push and take a filename as parameter
### if filename param is present, append timestamp to file and open it in vim
tn() {
	cd ~/Documents/notes
	./sync.sh
	if [ ! -z "$1" ]; then
		echo -e "\n# note taken on $(date --rfc-3339='seconds') $(date +%s)\n" >> $1
		vimx "+ normal G$" +startinsert $1
	fi
}

### return number of jobs
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}
