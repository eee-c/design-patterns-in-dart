#!/bin/sh

if [ "$2" != "" ]
then
    gnuplot -e "filename='$1'; image='$2'" tool/benchmark_summary.gnuplot

elif [ "$1" = "-h" -o "$1" = "--help" ]
then
    echo "visualize.sh [tab_separated_summary_data_file, [png_output_file]]"

elif [ "$1" != "" ]
then
    gnuplot -e "filename='$1'" tool/benchmark_summary.gnuplot

else
    gnuplot tool/benchmark_summary.gnuplot

fi
