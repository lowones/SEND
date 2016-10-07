#!/bin/bash

if [ ${#} -ne 1 ];
then
   echo -e "\nUsage: ${0} perl_script\n"
   exit
else
   script=${PWD}/${1}
fi

if [ -f ${script} ];
then
   echo ${script}
   echo "good"
   assh dc2prnb01 perl < ${script}
#   assh dc2prnb03 perl < ${script}
#   assh dc1pjump01 perl < ${script}
else
   echo "${script} does not exist\n"
   exit
fi

exit


#assh dc1pjump01 perl < perl_script.pl
