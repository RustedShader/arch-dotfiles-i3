#!/bin/bash

killall polybar && polybar mybar 2>&1 | tee -a /tmp/polybar.log 

