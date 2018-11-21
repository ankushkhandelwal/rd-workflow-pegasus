#!/bin/bash
set -e
maindir=$PWD
echo $maindir
export PATH=/opt/conda/bin:/home/ankush_kwal/bin:/home/ankush_kwal/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export KERAS_BACKEND=tensorflow
export PYTHONPATH=/opt/conda/envs/gdalenv/lib/python2.7/site-packages/
tar -xzf $1 -C $PWD
tar -xzf $2 -C $PWD
tar -xzf $3.tar.gz -C $PWD

cd scripts
python ProcessZip_wrapper.py $maindir/$3/ $3.txt
cd ..
tar -czf $maindir/$4 -C $maindir/ $3
