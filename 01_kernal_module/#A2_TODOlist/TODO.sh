#!/bin/bash

#A nice and beautifull to do list 

TASK_FILE="todo_tasks.txt"

# Reset text formatting
reset="\033[0m"
Bold_Text="\033[1m"
Black_circle="\u26AB"

#colors
LIGHT_RED="\033[0;91m"
RED="\033[0;31m"
GREEN="\033[0;32m"
MAGENTA="\033[0;35m"
Light_Yellow="\033[0;93m"

YELLOW='\033[0;33m'
TRUE_SYMBOL="\xE2\x9C\x93"

# Check if the task file exists and create it if not
if [ ! -f "$TASK_FILE" ]; then
    touch "$TASK_FILE"
fi


add_task(){

	echo -e -n "${Light_Yellow}What is your task title sunshine ? ${reset}"
	read TASK_TITLE
        echo -e -n "${Light_Yellow}Enter due date ( optional but i guess you should 😃 ) :  ${reset}"
        read DUE_Date
	if [ ! -z DUE_Date ] ; then
		echo "[	]"$TASK_TITLE"		"$DUE_Date >> $TASK_FILE
	else
                echo "[	]"$TASK_TITLE"		" >> $TASK_FILE
	fi

        echo -e "${Light_Yellow}Finished 👍 ${reset}"

}


list_tasks(){

	if [ -s $TASK_FILE ] ; then
		cat $TASK_FILE
	else
		echo -e "${RED} 😃  manta 3arf enoh fadi  ${reset}"
	fi

}

Mark_tasks(){

        echo -e -n "${Light_Yellow}Enter the task number :  ${reset}"
	read NUM

	sed -i "${NUM}s/\(\[\s*\]\)/\[\\✓\\]/" "$TASK_FILE"
	echo -e "${Light_Yellow}Task marked as completed 👍 ${reset}"
}

remove_task(){


        echo -e -n "${Light_Yellow}Enter the task number :  ${reset}"
        read NUM

	sed -i "${NUM}d" "$TASK_FILE"
        echo -e "${Light_Yellow}Task marked removed completed 👍 ${reset}"

}

while true ;do

	echo -e "${GREEN}${Bold_Text}To-Do List Menu:${reset}"
    	echo -e "${LIGHT_RED}1. Add Task${reset}"
    	echo -e "${LIGHT_RED}2. List Tasks${reset}"
    	echo -e "${LIGHT_RED}3. Mark Task as Completed${reset}"
    	echo -e "${LIGHT_RED}4. Remove Task${reset}"
    	echo -e "${LIGHT_RED}5. Quit${reset}"
    	echo -e -n "${LIGHT_RED}${Bold_Text}Enter your choice: ${reset}"

	read choice
	case $choice in
		1) add_task ;;
		2)list_tasks ;;
		3) Mark_tasks ;;
		4)remove_task ;;
		5) exit 0 ;;
		*) echo -e "${RED}ERROR :try again.${reset}" ;;
	esac
done
