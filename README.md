Contents:

* [3000char.html](https://github.com/linse/anki-prompt/blob/master/3000char.html) original character frequency list
* [README](https://github.com/linse/anki-prompt/blob/master/README) this file
* [pagetext.txt](https://github.com/linse/anki-prompt/blob/master/pagetext.txt) character frequency list without html tags
* [prompt.pl](https://github.com/linse/anki-prompt/blob/master/prompt.pl) Perl script displaying a random character

The character frequency list is from http://www.zein.se/patrick/3000char.html and I saved it without tags to pagetext.txt.

Put the following in your .bashrc and/or .bash_profile (or other shell rc).
In fact you only need the HANZI part, but I also have a symbol colored red or green, depending on the exit status of the last command.


``` bash
function exitstatus {

	EXITSTATUS="$?"
	BOLD="\[\e[1m\]"
	RED="\[\e[1;31m\]"
	MAGENTA="\[\e[35;1m\]"
	BLUE="\[\e[34;1m\]"
	GREEN="\e[0;32m\]"
	OFF="\[\e[m\]"

	HANZI=`<full path to the script>/anki-prompt/prompt.pl`

	if [ "$EXITSTATUS" -eq "0" ]
		then
			PS1="${HANZI}${BOLD}${MAGENTA}\u${OFF} ${BLUE}\w${OFF} ${GREEN}☠${OFF} "
	else
		PS1="${HANZI}${BOLD}${MAGENTA}\u${OFF} ${BLUE}\w${OFF} ${RED}☠${OFF} "
	fi

	PS2="${BOLD}>${OFF} "

}

PROMPT_COMMAND=exitstatus
```
