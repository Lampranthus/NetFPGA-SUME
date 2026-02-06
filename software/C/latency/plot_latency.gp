#!/usr/bin/gnuplot
set terminal pngcairo size 1600,1200 enhanced font 'Verdana,12'
set output 'latency_analysis.png'
set multiplot layout 2,2 title 'Análisis de Latencia vs Tamaño de Payload' font 'Verdana,14'

set title 'Latencia Media y Desviación Estándar'
set xlabel 'Tamaño de Payload (bytes)'
set ylabel 'Latencia (μs)'
set grid
plot 'latency_results.csv' using 1:4:5 with yerrorlines title 'Media ± σ' lc rgb 'blue', \
     'latency_results.csv' using 1:4 with lines notitle lc rgb 'blue'

set title 'Percentiles de Latencia (P50, P95, P99)'
set xlabel 'Tamaño de Payload (bytes)'
set ylabel 'Latencia (μs)'
set grid
plot 'latency_results.csv' using 1:7 with lines title 'P50' lw 2 lc rgb 'green', \
     'latency_results.csv' using 1:8 with lines title 'P95' lw 2 lc rgb 'orange', \
     'latency_results.csv' using 1:9 with lines title 'P99' lw 2 lc rgb 'red'

set title 'Rango de Latencia (Mín-Máx)'
set xlabel 'Tamaño de Payload (bytes)'
set ylabel 'Latencia (μs)'
set grid
plot 'latency_results.csv' using 1:3:2 with yerrorlines title 'Rango' lc rgb 'purple' fill transparent solid 0.2

set title 'Coeficiente de Variación (σ/μ)'
set xlabel 'Tamaño de Payload (bytes)'
set ylabel 'CV (σ/μ, %)'
set grid
plot 'latency_results.csv' using 1:($5/$4*100) with linespoints title 'Coeficiente de Variación' lc rgb 'brown' lw 2

unset multiplot
