#!/usr/bin/env bash

usage()
{
    # Display Usage
   echo "Removes specified git submodule from the repository in the current working directory."
   echo
   echo "Syntax: remove_submodule [-s|h]"
   echo "options:"
   echo "s     Specify submodule to remove (-s 'submodule')"
   echo "h     Print this Help."
   echo
}

while getopts s:h flag
do
    case "${flag}" in
    s) 
        submodule=${OPTARG};;
    h) 
        usage
        exit;;
    esac
done

if [ -z "$submodule" ]
then
   usage
   exit
fi

git rm $submodule
rm -rf .git/modules/$submodule
git config -f .git/config --remove-section submodule.$submodule 2> /dev/null