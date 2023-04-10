#! /bin/bash

# Condor scratch dir
condor_scratch=$(pwd)
echo "$condor_scratch" > _condor_scratch_dir.txt

# Add unzip to the environment
if [ -x $condor_scratch/unzip ]; then
    mkdir $condor_scratch/local_bin
    mv $condor_scratch/unzip $condor_scratch/local_bin
    export PATH="$PATH:$condor_scratch/local_bin"
fi

# Untar input files
tar xfz "input_TT01j.tar.gz"

# Setup CMS framework
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh

# Purdue wokaround
unset CXX CC FC
# Run
iscmsconnect=1 bash -x gridpack_generation.sh "TT01j" "addons/cards/SMEFTsim_topU3l_MwScheme_UFO/TT01j" "condor" CODEGEN "" ""
exitcode=$?

if [ $exitcode -ne 0 ]; then
    echo "Something went wrong while running CODEGEN step. Exiting now."
    exit $exitcode
fi

# Pack output and condor scratch dir info
cd "${condor_scratch}/TT01j"
mv "${condor_scratch}/_condor_scratch_dir.txt" .
XZ_OPT="--lzma2=preset=9,dict=512MiB" tar -cJpsf "${condor_scratch}/TT01j_output.tar.xz" "TT01j_gridpack" "_condor_scratch_dir.txt"
# tar -jcf "${condor_scratch}/TT01j_output.tar.xz" "TT01j_gridpack" "_condor_scratch_dir.txt"

# Stage-out sandbox
# First, try XRootD via stash.osgconnect.net
echo ">> Copying sandbox via XRootD"
xrdcp -f "${condor_scratch}/TT01j_output.tar.xz" "root://stash.osgconnect.net:1094//user/beren/tmp.ZbDxvp0v7b/TT01j_output.tar.xz"
exitcode=$?
if [ $exitcode -eq 0 ]; then
    exit 0
else
    echo "The xrdcp command below failed:"
    echo "xrdcp -f ${condor_scratch}TT01j_output.tar.xz root://stash.osgconnect.net:1094//user/beren/tmp.ZbDxvp0v7b/TT01j_output.tar.xz"
fi
        # Temporarily disable condor_chirp
        # until this feature comes back in CMS
## Second, try condor_chirp
#echo ">> Copying sandbox via condor_chirp"
#CONDOR_CHIRP_BIN=$(command -v condor_chirp)
#if [ $? != 0 ]; then
#    if [ -n "${CONDOR_CONFIG}" ]; then
#        CONDOR_CHIRP_BIN="$(dirname $CONDOR_CONFIG)/main/condor/libexec/condor_chirp"
#    fi
#fi
#"${CONDOR_CHIRP_BIN}" put -perm 644 "${condor_scratch}/TT01j_output.tar.xz" "TT01j_output.tar.xz"
#exitcode=$?
#if [ $exitcode -ne 0 ]; then
#    echo "condor_chirp failed. Exiting with error code 210."
#    exit 210
#fi
#rm "${condor_scratch}/TT01j_output.tar.xz"

