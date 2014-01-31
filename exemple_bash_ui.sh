#!/bin/bash

#
#	MINT UI EXEMPLE
#	Created by Dominique DA SILVA on 30/01/2014.
#	Copyright (c) 2014 Agonia Studios. All rights reserved.
#
#	https://github.com/atika/MintUI.git
#


MUI_TITLE="MINT UI — EXEMPLE"

MUI_SPLASH[0]="  MINT UI  "
MUI_SPLASH[1]="Welcome on `hostname` @ `date +'%d %B %Y'`"
MUI_SPLASH[2]=" Your are logged as user $USER "
MUI_SPLASH_WAIT=2
MUI_RETURNMENU_STR="Return to menu"
MUI_RETURNHOME_MSG="RETURN AT HOME"
MUI_EXITMSG="GOODBYE $USER !"
MUI_CONFIRM_YES="CONFIRM"
MUI_CONFIRM_CANCEL="CANCEL"
MUI_CONFIRM_PROMPT="Execute the command ?"


source mint_ui.sh


program_path=`dirname $0`
cd $program_path

function menu_root {
	while true; do
		clear

		printTitle "Welcome on `hostname` @ `date +'%d %B %Y'`"

		printOption "desc" "A" "HOME" "List home folder"
		printOption "desc" "B" "UPTIME" "System uptime"
		printOption "desc" "C" "INPUT" "Input exemple"
		printOption "desc" "D" "SUBMENU >" "Create another menu"
		printOption "desc" "E" "CONFIRM" "Confirm an action"
		printOption "desc" "Q" "QUIT" "Exit program"

		printOption "result" "DATE" "`date +'%a %d %B %Y'`"
		printOption "result" "LOAD AVERAGE" "`uptime | awk -F'load averages:' '{ print $2 }'`"
		printOption "result" "USER" "$USER"

		echo
		read -p " What do you want to do ? " -n1 rep

		case $rep in
			[aA]* )
				clearscreen
				printTitle "Home folder" "$(echo ~)"
				while read folder ; do 
					qte=$(ls "$folder" | wc -l)" items."
					printOption "result" "$folder" "$qte"
				done < <(ls -d ~/*)
				break;;
			[bB]* )
				clear
				printTitle "System Uptime"
				popup "System Uptime" "$(uptime)" "for host `hostname`"
				break;;
			[cC]* )
				clearscreen
				input "What is your name ? "
				clearscreen
				echo "  Hello $rep ! Nice to meet you !"
				sleep 3
				break;;
			[dD]* )
				menu_submenu
				break;;
			[eE]* )	
				confirm "Do you really want to make this ?" "echo ok you confirm, I execute."
				break;;
			[qQ]* )
				quitter;
				break;;
			* ) returnhome;;
		esac
	done

	returnmenu "menu_root"

}


function menu_submenu {
	while true; do
		clear

		printTitle "This is a Submenu"

		printOption "desc" "A" "OPTION" "Another option"
		printOption "desc" "B" "OPTION" "Another option"
		printOption "desc" "C" "OPTION" "Another option"

		echo
		read -p " Choose an option : " -n1 rep

		case $rep in
			* ) clearscreen; echo "You choose $rep"; sleep 2; returnhome; break;;
		esac
	done

	returnmenu "menu_root"
}

splashScreen;
menu_root;