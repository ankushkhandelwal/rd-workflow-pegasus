#!/bin/bash
set -e
maindir=$PWD
ls ~/
ls $PWD
cp /ccg/home/ankush/building-detection/codes/.gbdx-config $HOME
export PATH=/opt/conda/bin:/home/ankush_kwal/bin:/home/ankush_kwal/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export KERAS_BACKEND=tensorflow
export PYTHONPATH=/opt/conda/envs/gdalenv/lib/python2.7/site-packages/

python /ccg/home/ankush/bd-workflow-pegasus/module-test.py

