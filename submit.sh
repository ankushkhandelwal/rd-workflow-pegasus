#!/bin/bash

set -e

TOP_DIR=`dirname $0`
cd $TOP_DIR

sdate=$1
edate=$2
boxfile=$3
boxlist=$4
jobname=$5
echo $jobname

export RUN_ID=$jobname-`date +'%s'`
export RUN_DIR=/local-scratch/$USER/workflow/$RUN_ID
export OUT_DIR=/local-scratch/http/$USER/$jobname\_clip
mkdir -p generated/$jobname
mkdir -p $RUN_DIR
mkdir -p $OUT_DIR

# create a site catalog from the template
envsubst < sites.template.xml > generated/sites.xml

# generate a transformation catalog
./tc-generator.sh >generated/tc.data

# generate the workflow
./dax-generator.py $boxfile $sdate $edate $boxlist $jobname $jobname


# plan and submit
pegasus-plan \
    --conf pegasus.conf \
    --sites condor_pool \
    --output-site local \
    --cleanup inplace \
    --relative-dir $RUN_ID \
    --dir $RUN_DIR \
    --dax generated/dax-stage1.xml \
    --submit


#poll and wait to finish
pegasus-status -l -w /local-scratch/$USER/workflow/$RUN_ID/$RUN_ID/
