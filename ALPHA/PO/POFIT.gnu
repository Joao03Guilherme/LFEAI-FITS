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

# Fit gaussian function
f1(x) = a1*exp(-((x-b1)**2)/(2*c1**2)) + d1 
a1 = 200
b1 = 370
c1 = 50
d1 = 100

x0 = 365
x1 = 380

# Fit exponential tail
f2(x) = a2*exp(b2*x) 
a2 = 1
b2 = 0.01

fit [x0:x1] f1(x) "PO5-7X10.txt" using 1:2:(sqrt($2)) via a1,b1,c1,d1
fit [100:x0] f2(x) "PO5-7X10.txt" using 1:2:((sqrt($2)<1?1:sqrt($2))) via a2,b2

# Plota os dados
plot "PO5-7X10.txt" skip 5 using 1:2:(sqrt($2)) with yerrorbars ls 1 title "Dados experimentais", [100:x0] f2(x) ls 9 lw 5 title "Cauda exponencial", [x0:x1] f1(x) ls 7 lw 5 title "Pico alfa"