# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Espectro de emissão do ^{210}Po"
set xlabel "Canal"
set ylabel "Contagens"

set xrange [0:450]
set yrange [0:300]

# Set step size
set xtics 50
set ytics 50

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

# Fit gaussian
f(x) = a*exp(-((x-b)**2)/(2*c**2)) + d 
a = 200
b = 370
c = 50
d = 100

x0 = 365
x1 = 380

fit [x0:x1] f(x) "PO5-7X10.txt" skip 5 using 1:2:(sqrt($2)) via a,b,c,d

# Plota os dados
plot "PO5-7X10.txt" skip 5 using 1:2:(sqrt($2)) with yerrorbars ls 1 title "Dados experimentais", [x0:x1] f(x) ls 7 title "Pico alfa"

# Save to file
set terminal png
set output "PO5-7X10.png"
replot

