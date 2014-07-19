#!/bin/sh

mkdir -p tmp
cat /dev/null > tmp/benchmark_loop_runs.tsv
cat /dev/null > tmp/benchmark_summary.tsv

echo "Running benchmarks..."
for X in 10 100 1000 10000 100000
do
    ./tool/benchmark.dart --loop-size=$X
    ./tool/benchmark_single_dispatch_iteration.dart --loop-size=$X
    ./tool/benchmark_visitor_traverse.dart --loop-size=$X
done
echo "Done. Results stored in tmp/benchmark_loop_runs.tsv."

echo "Building summary..."

./tool/summarize_results.dart

echo "Done. Results stored in tmp/benchmark_summary.tsv."

echo ""
echo "To view in gnuplot, run tool/visualize.sh."
