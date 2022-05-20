#!/bin/bash
pip install pandas
pip install matplotlib

cd code

echo 'Compiling on Fortran!'
gfortran multF.f95 -o multF
echo 'Running on Fortran:'
./multF
echo 'Done!'

echo '-------------------------'

echo 'Compiling on C!'
gcc multC.c -o multC
echo 'Running on C:'
./multC
echo 'Done!'

echo '-------------------------'

echo 'Plotting graphs...'
python3 generateGraphs.py

echo 'Graphs are created!'