#!/bin/sh

RESULTS_FILE=tmp/benchmark_loop_runs.tsv
SUMMARY_FILE=tmp/benchmark_summary.tsv
LOOP_SIZES="10 100 1000 10000 100000"

# Initialize artifact directory
mkdir -p tmp
cat /dev/null > $RESULTS_FILE
cat /dev/null > $SUMMARY_FILE

# Individual benchmark runs of different implementations
echo "Running benchmarks..."
for X in $LOOP_SIZES
do
    ./tool/benchmark.dart --loop-size=$X \
        | tee -a $RESULTS_FILE
    ./tool/benchmark_single_dispatch_iteration.dart --loop-size=$X \
        | tee -a $RESULTS_FILE
    ./tool/benchmark_visitor_traverse.dart --loop-size=$X \
        | tee -a $RESULTS_FILE
done
echo "Done. Results stored in $RESULTS_FILE."

# Summarize results
echo "Building summary..."
./tool/summarize_results.dart < $RESULTS_FILE > $SUMMARY_FILE
echo "Done. Results stored in $SUMMARY_FILE."

# Visualization ready
echo ""
echo "To view in gnuplot, run tool/visualize.sh."
