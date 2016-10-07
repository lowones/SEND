#!/bin/bash

assh dc2prnb03 "uname -a;"
assh dc2prnb03 $(<script.txt)
