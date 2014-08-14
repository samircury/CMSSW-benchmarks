#!/bin/bash
CPU=$1
nohup taskset -c $CPU cmsRun -e ../PSet.py &
