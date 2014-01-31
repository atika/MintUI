# Mint UI#
Initially, this bash script has been written to have an mobile UI aspect and better usage of a command prompt with a smartphone.

[https://github.com/atika/MintUI.git](https://github.com/atika/MintUI.git)

![](http://i.imgur.com/ZYotQOA.png "Mint UI")

## Some commands ##
** Display a splash screen **

	splashScreen

** Print a title **

	printTitle "My Title Here"
	
** Print menu options **
	
	printOption "desc" "A" "HOME" "List home folder"
	
** Print a result (alternate row) **

	printOption "result" "username" "$USER"
	
** Prompt user to input something **

	input "What is your name ? "
	echo "Result is $rep"
	
** Prompt user to confirm an action **

	confirm "Do you really want to make this ?" "echo ok you confirm, I execute."
	
***usage :** confirm "message" "action"*

** Popup **

	popup "Popup Title" "Message line 1" "Message line 2"

-----
	
** Return to menu prompt **

	returnmenu "menu_root"
	
** Return to home **

	returnhome
	
** Exit program **

	quitter
	
	

	
	
