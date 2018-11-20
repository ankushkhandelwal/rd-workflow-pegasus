#!/bin/bash

set -e

TOP_DIR=`dirname $0`
cd $TOP_DIR

syear=$1
cntyname=$2
jobname=$3
echo $jobname

export RUN_ID=$jobname-`date +'%s'`
export RUN_DIR=/local-scratch/$USER/workflow/$RUN_ID
export OUT_DIR=/local-scratch/http/$USER/$jobname\_stage6
mkdir -p generated/$jobname
mkdir -p $RUN_DIR
mkdir -p $OUT_DIR


# create a site catalog from the template
envsubst < sites.template.xml > generated/sites.xml

# generate a transformation catalog
./tc-generator.sh >generated/tc.data

# generate the workflow
./dax-generator-prediction-stage.py /local-scratch/http/$USER/$jobname\_stage1/outputs/ss_grid_sel.shp /local-scratch/http/$USER/$jobname\_stage1/outputs/ss_grid_prune.txt $syear image_footprint_south-sudan-meta.csv $jobname


# plan and submit
pegasus-plan \
    --conf pegasus.conf \
    --sites condor_pool \
    --output-site local \
    --cleanup inplace \
    --relative-dir $RUN_ID \
    --dir $RUN_DIR \
    --dax generated/dax-generator-prediction-stage.xml \
    --submit


#poll and wait to finish
pegasus-status -l -w /local-scratch/$USER/workflow/$RUN_ID/$RUN_ID/
