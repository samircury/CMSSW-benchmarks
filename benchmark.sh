
# You should source this. Otherwise CMSSW won't be happy. 
# I really wish I could run the sh script, but only sourcing works for now.

INIT_DIR=$PWD
# Define directory to contain all the scratch area.
SCRATCH_AREA=run1

echo "creating scratch area: $SCRATCH_AREA"
mkdir $SCRATCH_AREA
cd $SCRATCH_AREA

echo "Loading CMSSW from CVMFS"
# Start CMSSW_5_3_8_patch3 area
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc5_amd64_gcc472
cmsrel CMSSW_5_3_8_patch3
cd CMSSW_5_3_8_patch3/src
cmsenv
echo "Now Im at $PWD"

# Get the configuration from Github
wget --no-check-certificate https://raw.githubusercontent.com/samircury/CMSSW-benchmarks/master/PSet.py

NCPUS=$(cat /proc/cpuinfo  | grep "model name" -c)
for ((CPU=0 ; CPU<=${NCPUS}; CPU++)) ; do
	mkdir $CPU
	cd $CPU
	echo "AAAAAAAAA $CPU"
	$INIT_DIR/run.sh $CPU
	cd ..
	#echo $CPU
done
cd $INIT_DIR
CPU=""
