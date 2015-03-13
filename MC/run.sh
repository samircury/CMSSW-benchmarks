#!/bin/bash

mkdir /tmp/mcbenchmark
cd /tmp/mcbenchmark
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc491
/cvmfs/cms.cern.ch/common/scramv1 project CMSSW CMSSW_7_3_0 &> /dev/null
cd CMSSW_7_3_0/src/
eval `/cvmfs/cms.cern.ch/common/scramv1 runtime -sh`
cmsRun -e /tmp/CMSSW-benchmarks-master/MC/H130GGgluonfusion_13TeV_cfi_GEN_SIM.py &> cmssw.log
AVG_TPE=$(grep AvgEventCPU FrameworkJobReport.xml | awk -F'"' '{print $4}')
rm -Rf /tmp/mcbenchmark
echo "CMSTimePerEventMC = $AVG_TPE
--"
