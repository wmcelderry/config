#!/usr/bin/gnuplot

set timefmt "%d-%m-%Y %H:%M:%S"

set autoscale y
set autoscale x

set format x "%d-%m %H:%M"

set xdata time
set style line 1 lt 1 lw 1
plot "~/battery.log" using 1:4 w l ls 1


pause -1
