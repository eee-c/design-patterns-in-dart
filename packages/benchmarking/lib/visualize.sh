#!/bin/sh

gnuplot=packages/dpid_benchmarking/benchmark_summary.gnuplot

if [ "$2" != "" ]
then
    gnuplot -e "filename='$1'; image='$2'" $gnuplot

elif [ "$1" = "-h" -o "$1" = "--help" ]
then
    echo "visualize.sh [tab_separated_summary_data_file, [png_output_file]]"

elif [ "$1" != "" ]
then
    gnuplot -e "filename='$1'" $gnuplot

else
    gnuplot $gnuplot

fi
