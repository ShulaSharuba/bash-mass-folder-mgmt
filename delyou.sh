#!/bin/bash

read -p "Enter number of files to match : " fNum

list=()
  while IFS= read -r line; do
    list+=( "$line" )
  done < <( find -type d )

unset list[0] # Remove current dir
list=( "${list[@]}" ) # Re-index

listLength=${#list[@]}
  for (( i=0; i<${listLength}; i++ )); do
    listCount+=( $(find "${list[$i]}" -type f | wc -l) )
  done

for i in "${!list[@]}"; do
  if [[ "${listCount[i]}" = "${fNum}" ]]; then
    echo -n "${list[$i]}" | sed 's|.*|"&\/" |'
  fi
done
