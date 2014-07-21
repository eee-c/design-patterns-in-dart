#!/bin/sh

RESULTS_FILE=tmp/benchmark_loop_runs.tsv
SUMMARY_FILE=tmp/benchmark_summary.tsv

# # Initialize artifact directory
mkdir -p tmp
cat /dev/null > $RESULTS_FILE
cat /dev/null > $SUMMARY_FILE

# Compile
wrapper='function dartMainRunner(main, args) { main(process.argv.slice(2)); }';
dart2js -o tool/benchmark.dart.js \
           tool/benchmark.dart
echo $wrapper >> tool/benchmark.dart.js

dart2js -o tool/benchmark_single_dispatch_iteration.dart.js \
           tool/benchmark_single_dispatch_iteration.dart
echo $wrapper >> tool/benchmark_single_dispatch_iteration.dart.js

dart2js -o tool/benchmark_visitor_traverse.dart.js \
           tool/benchmark_visitor_traverse.dart
echo $wrapper >> tool/benchmark_visitor_traverse.dart.js

# Individual benchmark runs of different implementations
echo "Running benchmarks..."
for X in 10 100 1000 10000 100000
do
    node ./tool/benchmark.dart.js --loop-size=$X \
        | tee -a $RESULTS_FILE
    node ./tool/benchmark_single_dispatch_iteration.dart.js --loop-size=$X \
        | tee -a $RESULTS_FILE
    node ./tool/benchmark_visitor_traverse.dart.js --loop-size=$X \
        | tee -a $RESULTS_FILE
done
echo "Done. Results stored in $RESULTS_FILE."

# # Summarize results
echo "Building summary..."
./tool/summarize_results.dart < $RESULTS_FILE > $SUMMARY_FILE
echo "Done. Results stored in $SUMMARY_FILE."

# Visualization ready
echo ""
echo "To view in gnuplot, run tool/visualize.sh."
