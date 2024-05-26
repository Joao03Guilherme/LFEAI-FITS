# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Relação entre a resolução e a energia"
set xlabel "E [keV]"
set ylabel "Resolução"

set xrange [0:2000]
set yrange [0:0.13]

# Set step size
set xtics 250
set ytics 0.02

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

f(x) = a/(sqrt(x)+b) + c
fit f(x) "ENERGYRES.txt" using 1:2:3:4 xyerror via a,b,c

set label at 1300, 0.09 sprintf("$\\sfrac{\\chi^2}{n_{df}} =%.2f$", FIT_WSSR/FIT_NDF)

plot "ENERGYRES.txt" using 1:2:3:4 with xyerrorbars ls 1 title "Dados experimentais", f(x) title "a/(sqrt(x)+b) + c"