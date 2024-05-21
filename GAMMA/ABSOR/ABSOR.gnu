# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Atenuação na matéria"
set xlabel "Depth [mg/cm^2]"
set ylabel "ln(A/A_0)"

set xrange [0:8000]
set yrange [-1:0.2]

# Set step size
set xtics 1000
set ytics 0.1

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
fit f(x) "ABSOR.txt" using 1:2:3 via m, b

# Plot data and function
plot "ABSOR.txt" using 1:2:3 with yerrorbars ls 1 title "", f(x) ls 7 title "Reta de ajuste"

# Save fit parameters in txt
set print "ABSOR_fit.txt"
print "m = ", m
print "b = ", b
print  "m_err = ", m_err
print  "b_err = ", b_err
set print


# Save plot
set terminal png
set output "ABSOR.png"
replot

