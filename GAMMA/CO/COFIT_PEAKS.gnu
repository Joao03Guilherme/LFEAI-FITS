# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Espetro de emissão do ^{60}Co"
set xlabel "Canal"
set ylabel "Número de contagens"

set xrange [0:800]
set yrange [0:500]

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

x0 = 620
x1 = 690

x2 = 700
x3 = 760

# Gaussian 1
f1(x) = a1*exp(-((x-b1)**2)/(2*c1**2)) + d1
a1 = 10000
b1 = 650
c1 = 50
d1 = 10000

# Gaussian 2
f2(x) = a2*exp(-((x-b2)**2)/(2*c2**2)) + d2
a2 = 10000
b2 = 730
c2 = 50
d2 = 10000

fit [x0:x1] f1(x) "CO.txt" skip 5 using 1:2:(sqrt($2)) via a1, b1, c1, d1
Q1 = FIT_STDFIT**2
ndf1 = FIT_NDF

fit [x2:x3] f2(x) "CO.txt" skip 5 using 1:2:(sqrt($2)) via a2, b2, c2, d2
Q2 = FIT_STDFIT**2
ndf2 = FIT_NDF

plot "CO.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais", [x0:x1] f1(x) ls 4 title "Pico gamma 1", [x2:x3] f2(x) ls 7 title "Pico gamma 2"

# Save image to file
set terminal png
set output "CO_fit_peaks.png"
replot

# Save fit data
set print "CO_fit_peaks.txt"
print "Gaussian 1"
print "a1 = ", a1
print "b1 = ", b1
print "c1 = ", c1
print "d1 = ", d1   
print "Q1 = ", Q1
print "NDF1 = ", ndf1
print "Gaussian 2"
print "a2 = ", a2
print "b2 = ", b2
print "c2 = ", c2
print "d2 = ", d2
print "Q2 = ", Q2
print "NDF2 = ", ndf2
set printx
