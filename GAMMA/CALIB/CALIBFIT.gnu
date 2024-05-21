# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Calibração da energia do detetor"
set xlabel "Energia (keV)"
set ylabel "Canal"

set xrange [0:1400]
set yrange [0:800]

# Set step size
set xtics 200
set ytics 100

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

# Fit function
f(x) = m*x + b

m = 100
b = 100

fit f(x) "CALIB.txt" using 1:2:3 via m, b

# Plot data and function
plot "CALIB.txt" using 1:2:3 with yerrorbars ls 1 title "", f(x) ls 7 title "Reta de calibração"


