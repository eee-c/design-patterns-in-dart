# set terminal png size 1024,768
# set output  "tmp/benchmark_summary.png"
set style data histogram
set style histogram clustered
set style fill solid border
set xtics rotate out
set key tmargin
set yrange [0:]
plot for [COL=2:4] 'tmp/benchmark_summary.tsv' using COL:xticlabels(1) title columnheader
pause -1 "Hit any key to continue"
