#!/bin/bash
rm -f @name@.log; 
for i in @inputs@; do 
   echo ./@name@ \< $i >> @name@.log
  ./@name@ < $i  &>> @name@.log || exit 1
  echo >> @name@.log
done
