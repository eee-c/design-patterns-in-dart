#!/bin/sh

rm -f totals.csv

for X in 10 100 1000 10000 100000
do
    # echo ''
    # echo '=='
    # echo "Loop size: $X"
    ./tool/benchmark.dart --loop-size=$X
    # echo '--'
    ./tool/benchmark_single_dispatch_iteration.dart --loop-size=$X
    # echo '--'
    ./tool/benchmark_visitor_traverse.dart --loop-size=$X
done
