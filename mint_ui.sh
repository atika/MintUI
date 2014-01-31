#!/bin/bash

#
#	MINT UI
#	Created by Dominique DA SILVA on Jan 2013.
#	Copyright (c) 2014 Agonia Studios. All rights reserved.
#
#	https://github.com/atika/MintUI.git
#
#	2014-01 User can define scripts variables

# COLORS

cgris="\\033[1;30m"
crouge="\\033[1;31m"
cvert="\\033[1;32m"
cjaune="\\033[1;33m"
cbleu="\\033[1;34m"
cviolet="\\033[1;35m"
ccyan="\\033[1;36m"
cblanc="\\033[1;37m"

cnormal="\\033[0;39m"

fnoir="\\033[40m"
frouge="\\033[41m"
fvert="\\033[42m"
fjaune="\\033[43m"
fbleu="\\033[44m"
fviolet="\\033[45m"
fcyan="\\033[46m"
fgris="\\033[47m"

current_dir=`pwd`

cl=$(( $(tput cols) / 3 ))

function splashScreen {
	
	sleep 0.5
	
	colonnes=$(tput cols)

	clear
	
	# FOOTER
	footer=" Loading, wait a moment "

	tput cup $((`tput lines`-2)) $((($colonnes-${#footer})/2))
	echo -e "$cgris""$footer""$cnormal"

	# FOND BLEU 
	echo -ne "$fbleu"
	for ligne in `seq 4 10`
	do
		tput cup $ligne 2
		sleep 0.05
		printf "%$((`tput cols`-4))s" ""
	done

	# COINS
	tput cup 4 2; echo -e "$fcyan"" + "; 
	tput cup 4 $(($colonnes-5)); echo -e " + "; 
	tput cup 10 $(($colonnes-5)); echo -e " + "; 
	tput cup 10 2; echo -e " + ""$cnormal";

	# TEXTE
	for index in ${!MUI_SPLASH[*]}
	do
		line="${MUI_SPLASH[$index]}"
		sleep 0.05
		tput cup $(($index+6)) $((($colonnes-${#line})/2))
		if [[ $index -eq 0 ]]; then
			echo -e "$fnoir""$cbleu""$line""$cnormal"
		elif [[ $index -eq 2 ]]; then
			echo -e "$fbleu""$ccyan""$line""$cnormal"
		else
			echo -e "$fbleu""$line""$cnormal"
		fi
	done

	sleep $MUI_SPLASH_WAIT
	clear
}


function printline {
    c=$1
    printf "%$(tput cols)s\n" "" | sed s/' '/"${c:=_}"/g
}

function printTitle {

	colonnes=$(tput cols)
	line1=$MUI_TITLE
	line2=`echo $1 | tr '[:lower:]' '[:upper:]'`

	# LINE 1
	printf "\\033[44m""%$(tput cols)s" ""
	
	tput cup 0 0; echo -e "$fcyan"" + ""$fbleu"
	tput cup 0 $(($colonnes-3)); echo -e "$fcyan"" + ""$fbleu" 
	
	tput cup 0 $((($colonnes-${#line1})/2))
	echo -e "$ccyan""$line1"$cnormal
	
	# LINE 2
	printf "$fbleu""$cblanc""%$(tput cols)s" ""
	tput cup 1 $((($colonnes-${#line2})/2))
	echo -e "$line2""$cnormal"
	
	echo
}

option_row=0

function printOption {
	colonnes=$(tput cols)

	# arg1 : desc ou result
	case "$1" in
		"desc" )
			col1="$2  ""$cvert""$3""$cnormal"
			echo -ne " $col1"
			
			if [[ "x$4" != "x" ]]; then
				# Affiche la description
				tput cuf $((39-${#col1}))
				echo -e " $4"
			else
				echo
			fi
			
			echo -e "\\033[34m"`printline —`"$cnormal"
			return
		break;;
		
		"result" )
		
			if [[ $option_row -eq 0 ]]; then
				row_color=""
				option_row=1
			else
				row_color="$fbleu"
				option_row=0
			fi
			
			col1=" $2"
			result="$3 "
			
			tput sc 
			printf "$row_color""%$(tput cols)s" ""
			tput rc
			echo -ne "$row_color""$col1"
			tput cuf $(($colonnes-${#col1}-${#result}))
			echo -e "$ccyan""$result""$cnormal"
			return
		break;;

		* ) return ;;
	esac

}

function input {
	echo -ne " ""$fvert"" ? ""$cnormal""  $1 \n      > "
	read -p "" rep
}

function confirm {
	colonnes=$(tput cols)
	button_offset=$((($colonnes-28)/3))
	
	clearscreen

	echo -e " ""$frouge"" ! ""$cnormal"" $1 "
	echo
	
	# YES / NO
	tput cuf $button_offset
	echo -ne "$fvert"" $MUI_CONFIRM_YES ""$fnoir""$cvert"" Y ""$cnormal"
	tput cuf $button_offset
	echo -e "$frouge"" $MUI_CONFIRM_CANCEL ""$fnoir""$crouge"" N ""$cnormal"
	echo

	read -p " $MUI_CONFIRM_PROMPT " -n1 rep
	
	case $rep in
		[yY]* ) clearscreen; $2; break;;
	esac
	
}

function popup {

	sleep 0.05
	colonnes=$(tput cols)
	title="    $1    "
	line1=" $2 "
	line2=" $3 "
	clearscreen

	tput cup 3 2
	printf "$fbleu""$cblanc""%$(($colonnes-4))s"
	for i in 4 5 6 7; do
		tput cup $i 2
		printf "$fbleu""$cblanc""%$(($colonnes-4))s""$fcyan "
	done
	tput cup 8 3
	printf "$cnormal""$fcyan""%$(($colonnes-5))s"" "

	sleep 0.05

	tput cup 3 $((($colonnes-${#title})/2))
	echo -e $fbleu"$ccyan""$title"$cnormal; #titre

	tput cup 5 $((($colonnes-${#line1})/2)); #line1
	echo -e $fbleu"$line1"$cnormal
	tput cup 6 $((($colonnes-${#line2})/2)); #line2
	echo -e $fbleu"$line2"$cnormal
	tput cup 10 1
	sleep 0.05
}

function clearscreen {
	lignes=$((`tput lines`-3))
	colonnes=$(tput cols)
	
	tput cup 2 0
	for i in $(seq 1 $lignes)
	do
		printf "$fnoir""%$(tput cols)s" ""
	done
	tput cup 3 0
	
}

function returnmenu {

		if [ "$1" == "menu_root" ]; then
				menuname=$MUI_RETURNHOME_MSG 
		else
				menuname="$MUI_RETURNMENU_STR "$(echo $1 | sed 's/menu_//g')
		fi
        echo -ne "\n  $frouge"
        read -p " $menuname " -n1
        echo -e "$cnormal"
        $1
        exit
}

function returnhome {
	clearscreen
	colonnes=$(tput cols)
	msg=" $MUI_RETURNHOME_MSG "
	tput cup 2 0
	printf "$fviolet""$cblanc""%$(tput cols)s" ""
	tput cup 2 $((($colonnes-${#msg})/2))
	echo -e $fviolet"$msg"$cnormal
	sleep 0.5

}

function quitter {
	clearscreen
	colonnes=$(tput cols)
	msg="  $MUI_EXITMSG  "
	tput cup 4 $((($colonnes-${#msg})/2))
	echo -e $frouge"$msg"$cnormal
	sleep 1
	cd $current_dir
	clear
	exit 0
}