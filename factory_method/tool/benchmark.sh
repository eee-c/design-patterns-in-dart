#!/bin/bash

source ./packages/dpid_benchmarking/_benchmark.sh

BENCHMARK_SCRIPTS=(
    tool/benchmark.dart
    tool/benchmark_map_of_factories.dart
    tool/benchmark_mirrors.dart
)

_run_benchmarks $1
