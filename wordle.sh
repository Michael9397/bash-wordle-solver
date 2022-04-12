#!/bin/sh
# good place to play with this list is https://wordlegame.org/

# Depending on your linux system, this file might be in a different location
WordListLocation='/usr/share/dict/words'

InLetters="lu"
OutLetters="paysngebd"

# Put a . if you don't know and the lower case letter if you do
First="."
Second="u"
Third="i"
Fourth="l"
Fifth="."

# empty if you don't know, and the lower case letter if you do
NotInFirst="l"
NotInSecond="l"
NotInThird=""
NotInFourth=""
NotInFifth=""

# This line makes us go to 5 character words only and 
# inputs the green letters in place
command="grep -E '^${First}${Second}${Third}${Fourth}${Fifth}$' $WordListLocation"

# This line gets rid of capital letters and any wrong guessed letters
command="$command | grep -v '[A-Z$OutLetters]'"

# This loop individually greps for each letter we know is in the answer
i=0
while (( i<${#InLetters} )); do
  command="$command | grep '${InLetters:$i:1}'"
  ((i++))
done

# this series starts putting in the yellow letters that we 
# know are in the wrong place.
if [ "${#NotInFirst}" -gt 0 ]
then
    command="$command | grep -v '["
    i=0
    while (( i<${#NotInFirst} )); do
        command="$command${NotInFirst:$i:1}"
        ((i++))
    done
    command="$command]....'"
fi

if [ "${#NotInSecond}" -gt 0 ]
then
    command="$command | grep -v '.["
    i=0
    while (( i<${#NotInSecond} )); do
        command="$command${NotInSecond:$i:1}"
        ((i++))
    done
    command="$command]...'"
fi

if [ "${#NotInThird}" -gt 0 ]
then
    command="$command | grep -v '..["
    i=0
    while (( i<${#NotInThird} )); do
        command="$command${NotInThird:$i:1}"
        ((i++))
    done
    command="$command]..'"
fi

if [ "${#NotInFourth}" -gt 0 ]
then
    command="$command | grep -v '...["
    i=0
    while (( i<${#NotInFourth} )); do
        command="$command${NotInFourth:$i:1}"
        ((i++))
    done
    command="$command].'"
fi

if [ "${#NotInFifth}" -gt 0 ]
then
    command="$command | grep -v '....["
    i=0
    while (( i<${#NotInFifth} )); do
        command="$command${NotInFifth:$i:1}"
        ((i++))
    done
    command="$command]'"
fi


# Uncomment out this command to see the grep command about to be run
# echo $command

# This runs the command
sh -c "${command}"

# This runs the command again but with a word count
echo "You currently have:"
sh -c "${command} | wc -l"
echo "options."