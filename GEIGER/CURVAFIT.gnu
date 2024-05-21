# Carrega os dados
set title "Patamar de Geiger"
set xlabel "Tensão (V)"
set ylabel "Contagens"

set xrange [500:1300]
set yrange [1000:1500]

# Set step size
set xtics 100
set ytics 250

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only\
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

f(x) = m*x + b 
m = 1000
b = 1000

fit [825:] f(x) "patamar.txt" using 1:2:(sqrt($2)) via m,b

# Plota os dados
plot [800:] "patamar.txt" using 1:2:(sqrt($2)) with yerrorbars ls 1 title "Dados experimentais", f(x) ls 7 title "Ajuste linear"

# Salva o gráfico
set terminal png
set output "patamar_fit.png"
replot

