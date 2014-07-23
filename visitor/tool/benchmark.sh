#!/bin/bash

source ./packages/dpid_benchmarking/_benchmark.sh

BENCHMARK_SCRIPTS=(
    tool/benchmark.dart
    tool/benchmark_single_dispatch_iteration.dart
    tool/benchmark_visitor_traverse.dart
)

_run_benchmarks $1
