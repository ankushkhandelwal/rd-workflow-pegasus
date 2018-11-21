#$1 means the Jobname
mkdir -p generated/$1
tar -czf generated/$1/rd-main.tar.gz -C /ccg/home/ankush/river-depth-estimation/ scripts
tar -czf generated/$1/rd-data.tar.gz -C /ccg/home/ankush/rd-workflow-pegasus/ data
