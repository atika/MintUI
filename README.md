# Mint UI#
Initially, this bash script has been written to have an mobile UI aspect and better usage of a command prompt with a smartphone.

[https://github.com/atika/MintUI.git](https://github.com/atika/MintUI.git)

![](http://i.imgur.com/ZYotQOA.png "Mint UI")

## Some commands ##
###Display a splash screen###

```bash 
	splashScreen
```

###Print a title###

```bash
	printTitle "My Title Here"
```

###Print menu options###

```bash	
	printOption "desc" "A" "HOME" "List home folder"
```

###Print a result (alternate row)###

```bash
	printOption "result" "username" "$USER"
```
	
###Prompt user to input something###

```bash
	input "What is your name ? "
	echo "Result is $rep"
```

###Prompt user to confirm an action###

```bash
	confirm "Do you really want to make this ?" "echo ok you confirm, I execute."
```

**usage :** confirm "message" "action"

###Popup###

```bash
	popup "Popup Title" "Message line 1" "Message line 2"
```

-----
	
###Return to menu prompt###

```bash
	returnmenu "menu_root"
```

###Return to home###

```bash
	returnhome
```

###Exit program###

```bash
	quitter
```
		
