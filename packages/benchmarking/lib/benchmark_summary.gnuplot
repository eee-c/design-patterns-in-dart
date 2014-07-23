if (!exists("filename")) filename='tmp/benchmark_summary.tsv'

if (exists("image")) set terminal png size 1024,768
if (exists("image")) set output image

set style data histogram
set style histogram clustered
set style fill solid border
set xtics rotate out
set key tmargin
set xlabel "Loop Size"
set ylabel "µs per run"
set yrange [0:]
plot for [COL=2:4] filename using COL:xticlabels(1) title columnheader

if ( exists("image")) print "Image saved to ", image
if (!exists("image")) pause -1 "Hit Enter to quit."
