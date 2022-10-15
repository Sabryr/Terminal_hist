#!/bin/bash

connect () {
  i=1;
  while [ $i -le 5 ];
  do
   printf '\033]2;'$i'\007'
   sleep 2
   let i=i+1
  done;
}

connect /home/sabryr/.new_bash_history


