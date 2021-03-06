#!/bin/bash
set -e
maindir=$PWD
echo $maindir
export PATH=/opt/conda/bin:/home/ankush_kwal/bin:/home/ankush_kwal/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export KERAS_BACKEND=tensorflow
export PYTHONPATH=/opt/conda/envs/gdalenv/lib/python2.7/site-packages/
tar -xzf $1 -C $PWD
tar -xzf $2 -C $PWD
ls 
mkdir $maindir/ZIPs
mkdir $maindir/Boxes
cd scripts
python ParseXML.py $maindir/data/$3 $4 $5 credentials.txt 
python ClipZip.py $maindir/data/$3 $maindir/ZIPs/ credentials.txt $maindir/Boxes/ $7
cd ..

for cdir in $maindir/Boxes/*/
do
	boxname=$(basename $cdir)
	tar -czf $maindir/$boxname.tar.gz -C $maindir/Boxes/ $boxname/
done
