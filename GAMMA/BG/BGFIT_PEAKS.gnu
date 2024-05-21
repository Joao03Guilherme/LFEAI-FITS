# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Espetro de radiação de fundo"
set xlabel "Canal"
set ylabel "Número de contagens"

set xrange [0:1000]
set yrange [0:2500]

# Set step size
set xtics 100
set ytics 500

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

plot "BG.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais"

x0 = 40
x1 = 70

x2 = 780
x3 = 820

x4 = 120
x5 = 140

x6 = 300
x7 = 365

# Gaussian 1
f1(x) = a1*exp(-((x-b1)**2)/(2*c1**2)) + d1
a1 = 1000
b1 = 50
c1 = 10
d1 = 100

# Gaussian 2
f2(x) = a2*exp(-((x-b2)**2)/(2*c2**2)) + d2
a2 = 1000
b2 = 800
c2 = 10
d2 = 100

# Gaussian 3
f3(x) = a3*exp(-((x-b3)**2)/(2*c3**2)) + d3
a3 = 1000
b3 = 130
c3 = 10
d3 = 100

# Gaussian 4
f4(x) = a4*exp(-((x-b4)**2)/(2*c4**2)) + d4
a4 = 10000
b4 = 330
c4 = 10
d4 = 100



fit [x0:x1] f1(x) "BG.txt" skip 5 using 1:2:(sqrt($2)) via a1, b1, c1, d1
Q1 = FIT_STDFIT**2
ndf1 = FIT_NDF

fit [x2:x3] f2(x) "BG.txt" skip 5 using 1:2:(sqrt($2)) via a2, b2, c2, d2
Q2 = FIT_STDFIT**2
ndf2 = FIT_NDF

fit [x4:x5] f3(x) "BG.txt" skip 5 using 1:2:(sqrt($2)) via a3, b3, c3, d3
Q3 = FIT_STDFIT**2
ndf3 = FIT_NDF

fit [x6:x7] f4(x) "BG.txt" skip 5 using 1:2:(sqrt($2)) via a4, b4, c4, d4
Q4 = FIT_STDFIT**2
ndf4 = FIT_NDF

plot "BG.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais", [x0:x1] f1(x) ls 4 title "Pico 1", [x4:x5] f3(x) ls 2 title "Pico 2", [x6:x7] f4(x) ls 3 title "Pico 3", [x2:x3] f2(x) ls 7 title "Pico 4"

# Save image to file
set terminal png
set output "BG_fit_peaks.png"
replot

# Save fit data
set print "BG_fit_peaks.txt"
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
print "Gaussian 3"
print "a3 = ", a3
print "b3 = ", b3
print "c3 = ", c3
print "d3 = ", d3
print "Q3 = ", Q3
print "NDF3 = ", ndf3
print "Gaussian 4"
print "a4 = ", a4
print "b4 = ", b4
print "c4 = ", c4
print "d4 = ", d4
print "Q4 = ", Q4
print "NDF4 = ", ndf4

set printx
