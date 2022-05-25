set title font "Helvetica,20"
set title "DAI vs ETH price"
set xdata time
set style data lines  
set datafile separator ','
set timefmt "%Y-%m-%d %H:%M:%S UTC"
set format x "%b\n%Y"
set format y "$%g"
set format y2 "$%g"
set xlabel "Date"
set ylabel "DAI price"
set y2label "ETH price"
set yrange [0:2]
set y2range [0:5600]
set xrange ["2019-11-19 00:00:00 UTC":"2022-05-21 00:00:00 UTC"]
set ytics 0.5 nomirror
set y2tics 1000 nomirror
set term png
set output "dai-eth.png"
plot "dai-usd-max.csv" using 1:2 title "DAI price" with lines, "eth-usd-max.csv" using 1:2 title "ETH price" with lines axes x1y2
set term svg
set output "dai-eth.svg"
plot "dai-usd-max.csv" using 1:2 title "DAI price" with lines, "eth-usd-max.csv" using 1:2 title "ETH price" with lines axes x1y2
