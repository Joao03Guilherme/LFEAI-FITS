# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Zona do patamar de Compton do ^{60}Co"
set xlabel "Canal"
set ylabel "Número de contagens"

set xrange [100:600]
set yrange [0:300]

# Set step size
set xtics 100
set ytics 50

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

plot "CO.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais"

x0 = 110
x1 = 140

x2 = 500
x3 = 540

# Fit gaussian 1
f1(x) = a1*exp(-((x-b1)/c1)**2) + d1

a1 = 300
b1 = 115
c1 = 10
d1 = 100

# Fit gaussian 2
f2(x) = a2*exp(-((x-b2)/c2)**2) + d2

a2 = 300
b2 = 510
c2 = 10
d2 = 100

fit [x0:x1] f1(x) "CO.txt" skip 5 using 1:2:(sqrt($2)) via a1, b1, c1, d1
fit [x2:x3] f2(x) "CO.txt" skip 5 using 1:2:(sqrt($2)) via a2, b2, c2, d2

plot "CO.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais", [x0:x1] f1(x) ls 9 title "Pico de Backscatter", [x2:x3] f2(x) ls 7 title "Joelho de Compton"

print "Pico de Backscatter: ", b1, " +/- ", c1
print "Joelho de Compton: ", b2, " +/- ", c2


# Save to file
set term png
set output "CO_fit_compton.png"
replot


