tmpdir=tmp
results_basename="benchmark_loop_runs"
summary_basename="benchmark_summary"
results_file=""
summary_file=""
type="dart"
loop_sizes="10 100 1000 10000 100000"
loop_sizes_js="10 100 1000 10000" # 100000"

_run_benchmarks () {
    parse_options $1
    initialize
    if [ "$type" = "dart" ]; then
        run_benchmarks
    else
        compile
        run_benchmarks_js
    fi
    summarize
    all_done
}

parse_options () {
  if [ "$1" = "-js" -o "$1" = "--javascript" ]
  then
      type="js"
  fi
}

# Initialize artifact directory
initialize () {
    if [ "$type" = "js" ]; then
        results_file=$tmpdir/${results_basename}_js.tsv
        summary_file=$tmpdir/${summary_basename}_js.tsv
    else
        results_file=$tmpdir/${results_basename}.tsv
        summary_file=$tmpdir/${summary_basename}.tsv
    fi

    mkdir -p $tmpdir
    cat /dev/null > $results_file
    cat /dev/null > $summary_file
}

# Compile to JavaScript
wrapper='function dartMainRunner(main, args) { main(process.argv.slice(2)); }';
compile () {
    for script in ${BENCHMARK_SCRIPTS[*]}
    do
        dart2js -o ${script}.js ${script}
        echo $wrapper >> ${script}.js
    done
}

# Individual benchmark runs of different implementations
run_benchmarks () {
    echo "Running benchmarks..."
    for X in $loop_sizes
    do
        for script in ${BENCHMARK_SCRIPTS[*]}
        do
            ./$script --loop-size=$X | tee -a $results_file
        done
    done
    echo "Done. Results stored in $results_file."
}

run_benchmarks_js () {
    echo "Running benchmarks..."
    for X in $loop_sizes_js
    do
        for script in ${BENCHMARK_SCRIPTS[*]}
        do
            node ./${script}.js --loop-size=$X | tee -a $results_file
        done
    done
    echo "Done. Results stored in $results_file."
}

# Summarize results
summarize () {
    echo "Building summary..."
    ./packages/dpid_benchmarking/summarize_results.dart < $results_file > $summary_file
    echo "Done. Results stored in $summary_file."
}

# Visualization ready
all_done () {
    echo ""
    echo "To view in gnuplot, run:"
    echo " packages/dpid_benchmarking/visualize.sh ${summary_file}"
}
