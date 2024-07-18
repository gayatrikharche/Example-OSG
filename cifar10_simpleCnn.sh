#!/bin/bash
echo "Hello OSPool from Job $1 running on `hostname`"

#untar the test and training data
tar zxf cifar-10-python.tar.gz
mkdir data
mv cifar-10-batches-py data

# run the pytorch model
python cifar10-simpleCnn.py --save-model --epochs 20

# remove the data directory
rm -r data
