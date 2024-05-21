# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Calibração linear em Energia do Pulser (LIN AMP)"
set xlabel "Canal do centroide [Chn]"
set ylabel "Energia marcada no Pulser [MeV]"

set xrange [0:1000]
set yrange [0:8]

# Set step size
set xtics 100
set ytics 0.50 format "%.2f"

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

# Fit linear
f(x) = a*x + b
fit f(x) "CALIB_LINAMP.txt" using 1:2:(1):(0.02) xyerrors via a, b

# Plot data
plot "CALIB_LINAMP.txt" using 1:2:(1):(0.02) with xyerrorbars ls 1 title "Dados", f(x) ls 2 title "Ajuste linear"

# Save data
set term png
set output "CALIB_LINAMP.png"
replot


 
