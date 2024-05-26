# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Espetro de emissão da fonte desconhecida"
set xlabel "Canal"
set ylabel "Número de contagens"

set xrange [0:1000]
set yrange [1:10000000]
set logscale y 10

# Set step size
set xtics 100
set ytics 100

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'skyblue' pt 7 ps 0.7 # Pontos azuis

set arrow from 44.609, 1 to 44.609, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "81 keV" at 44.609, 150000*1.9 rotate by 90 font ",6"

set arrow from 197.234, 1 to 197.234, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "356 keV" at 197.234, 150000*1.9 rotate by 90 font ",6"

set arrow from 167.264, 1 to 167.264, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "302 keV" at 167.264, 150000*1.9 rotate by 90 font ",6"

set arrow from 212.219, 1 to 212.219, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "383 keV" at 212.219, 150000*1.9 rotate by 90 font ",6"

set arrow from 253, 1 to 253, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "383 keV" at 253, 150000*1.9 rotate by 90 font ",6"

set arrow from 152.834, 1 to 152.834, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "276 keV" at 152.834, 150000*1.9 rotate by 90 font ",6"

set arrow from 16.859, 1 to 16.859, 150000 head filled size screen 0.01, 30, 60 ls 8
set label "31 keV" at 16.859, 150000*1.9 rotate by 90 font ",6"

plot "F1.txt" skip 5 using 1:2 every 3 with boxes ls 1 title "Dados experimentais"
