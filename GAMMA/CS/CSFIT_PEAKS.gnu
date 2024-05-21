# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Espetro de emissão do ^{137}Cs"
set xlabel "Canal"
set ylabel "Número de contagens"

set xrange [0:500]
set yrange [0:3000]

# Set step size
set xtics 50
set ytics 500

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

x0 = 12
x1 = 28

x2 = 350
x3 = 385

# Gaussian 1
f1(x) = a1*exp(-((x-b1)**2)/(2*c1**2)) + d1
a1 = 10000
b1 = 20
c1 = 5
d1 = 3000

# Gaussian 2
f2(x) = a2*exp(-((x-b2)**2)/(2*c2**2)) + d2
a2 = 10000
b2 = 370
c2 = 5
d2 = 10

fit [x0:x1] f1(x) "CS.txt" skip 5 using 1:2 via a1, b1, c1, d1
CHISQ_NDF1 = FIT_STDFIT**2

fit [x2:x3] f2(x) "CS.txt" skip 5 using 1:2 via a2, b2, c2, d2
CHISQ_NDF2 = FIT_STDFIT**2

plot "CS.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais", [x0:x1] f1(x) ls 4 title "Pico raios-X", [x2:x3] f2(x) ls 7 title "Fotopico"

# Save image to file
set terminal png
set output "CS_fit_peaks.png"
replot

# Save fit data
set print "CS_fit_peaks.txt"
print "Gaussian 1"
print "a1 = ", a1
print "b1 = ", b1
print "c1 = ", c1
print "d1 = ", d1   
print "CHISQ/NDF = ", CHISQ_NDF1
print "Gaussian 2"
print "a2 = ", a2
print "b2 = ", b2
print "c2 = ", c2
print "d2 = ", d2
print "CHISQ/NDF = ", CHISQ_NDF2
set print

