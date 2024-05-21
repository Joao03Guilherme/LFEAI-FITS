# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Zona do patamar de Compton do ^{137}Cs"
set xlabel "Canal"
set ylabel "Número de contagens"

set xrange [70:320]
set yrange [0:500]

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
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pont os pretos

# Find maximum value of y in a range of x in 250 and 300
stats "CS.txt" skip 5 every ::250::300 using 2 nooutput
max_y = STATS_max

# Do a fit of the gaussian data in the region x = 100 to x = 115
f(x) = a*exp(-((x-b)**2)/(2*c**2)) + d 

a = 4000
b = 110
c = 10
d = 1000

fit [100:115] f(x) "CS.txt" skip 5 using 1:2:(sqrt($2)) via a,b,c,d

f2(x) = a2*exp(-((x-b2)**2)/(2*c2**2)) + d2

a2 = 4000
b2 = 240
c2 = 10
d2 = 1000

x2 = 235
x3 = 260

fit [x2:x3] f2(x) "CS.txt" skip 5 using 1:2:(sqrt($2)) via a2,b2,c2,d2 

plot "CS.txt" skip 5 using 1:2:(sqrt($2)) every 2 with yerrorbars ls 1 title "Dados experimentais", [100:115] f(x) ls 7 title "Pico de backscatter", [x2:x3] f2(x) ls 9 title "Joelho de Compton"

# Save the plot to a file
set terminal png
set output "CS_fit_compton.png"
replot

# Save chisq, parameters and errors to a file
set print "CS_fit_compton.txt"
print "a = ", a
print "b = ", b
print "c = ", c
print "d = ", d
print "chisq = ", FIT_WSSR
print "a_err = ", a_err
print "b_err = ", b_err
print "c_err = ", c_err
print "d_err = ", d_err
print "Contagens do Joelho = ", max_y
set print

