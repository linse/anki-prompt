#anki-prompt
flashcards in the bash prompt

![the prompt](https://raw.github.com/linse/anki-prompt/master/screenshot.png)

Contents:

* [3000char.html](https://github.com/linse/anki-prompt/blob/master/3000char.html) original character frequency list
* [README](https://github.com/linse/anki-prompt/blob/master/README) this file
* [pagetext.txt](https://github.com/linse/anki-prompt/blob/master/pagetext.txt) character frequency list without html tags
* [prompt.pl](https://github.com/linse/anki-prompt/blob/master/prompt.pl) Perl script displaying a random character
* [screenshot.png](https://github.com/linse/anki-prompt/blob/master/screenshot.png) what it looks like

The character frequency list is from http://www.zein.se/patrick/3000char.html and I saved it without tags to pagetext.txt.

Edit the user configurable parameters at the top of the script (it won't run otherwise), then put the following in your .bashrc and/or .bash_profile (or other shell rc).
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

## prerequisites

The script uses [Color::Output](http://search.cpan.org/~animator/Color-Output-1.05/Output.pm) which is not packed in Debian systems. 
It incldues a fall-back to use [Term::ANSIColor](http://perldoc.perl.org/Term/ANSIColor.html) which is part of the standard perl modules.

On Linux system you might need to change the exitstatus function PS1 to include a \n:
``` bash
                        PS1="${HANZI}\n${BOLD}${MAGENTA}\u${OFF} ${BLUE}\w${OFF} ${GREEN}☠${OFF} "
```