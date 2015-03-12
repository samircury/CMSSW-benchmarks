#!/bin/bash

mkdir scratch
cd scratch
source /cvmfs/cms.cern.ch/cmsset_default.sh
cmsrel CMSSW_7_3_0
cd CMSSW_7_3_0/src/
cmsenv
cmsRun -e ../../../H130GGgluonfusion_13TeV_cfi_GEN_SIM.py
cd ../../..
