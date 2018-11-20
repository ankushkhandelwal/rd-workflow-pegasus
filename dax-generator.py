#!/usr/bin/env python

import glob
import math
import os
import re
import sys
import numpy as np

from Pegasus.DAX3 import *

top_dir = os.getcwd()

dax = ADAG('MINT')
cnty_file = sys.argv[1] # path of the admin boundary file
pgrd_file = sys.argv[2] # path of the ROI patch grid
cnty_name = sys.argv[3] # county ID
out_file  = sys.argv[4] # full path of the pruned patch grid file
prn_file  = sys.argv[5]
box_list = sys.argv[6]
thr1 = sys.argv[6]
thr2 = sys.argv[7]
job_name = sys.argv[8]

code_file = File('rd-main.tar.gz')
code_file.addPFN(PFN('file://' + top_dir + '/generated/' + job_name + '/rd-main.tar.gz', site='local'))
dax.addFile(code_file)

data_file = File('rd-data.tar.gz')
data_file.addPFN(PFN('file://' + top_dir + '/generated/' + job_name + '/rd-data.tar.gz', site='local'))
dax.addFile(data_file)

job = Job('raster-clip-wrapper.sh')
job.uses(code_file,link=Link.INPUT)
job.uses(data_file,link=Link.INPUT)

out_tar_file = File(out_file + '.tar.gz')
job.uses(out_tar_file, link=Link.OUTPUT, transfer=True)

job.addArguments(code_file,data_file,box_file,sdate,edate,out_file+'.tar.gz')
dax.addJob(job)

#box_ids = np.loadtxt(box_list)
#for curID in box_ids:
#	job = Job('river-depth-wrapper.sh')
#	job.uses(code_file,link=Link.INPUT)
#	job.uses(data_file,link=Link.INPUT)
#	job.uses(out_tar_file,link=Link.OUTPUT)
#	job.use

	

# Write the DAX
f = open('generated/dax-stage1.xml', 'w')
dax.writeXML(f)
f.close()

