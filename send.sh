#!/bin/bash

server='11.3.164.166'
#server='dc2prnb03'

assh dc2prnb03 "uname -a"
assh dc2prnb03 "bash -s" < script.sh
#assh dc2prnb03 "bash -s" < script.pl
