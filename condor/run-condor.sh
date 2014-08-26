# looks like this script is happy when sourced but not when executed
 # # #  # #!/bin/bash
. /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc5_amd64_gcc462
cmsrel CMSSW_5_3_8_patch3
cd CMSSW_5_3_8_patch3/src
cmsenv
echo "Im running at $HOSTNAME $PWD"
cp ../../PSet.py .
cmsRun -e PSet.py
# If we don't do this, the Couch report script will not find the 
# right version of ZLIB and will crash badly.
export LD_LIBRARY_PATH=""
../../report-fjr-couch-caltech FrameworkJobReport.xml
