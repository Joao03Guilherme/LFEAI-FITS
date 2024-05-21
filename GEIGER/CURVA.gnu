# Configura o Gnuplot para ignorar linhas de comentários
set datafile commentschars "#"

# Carrega os dados
set title "Curva de resposta Geiger-Muller"
set xlabel "Tensão (V)"
set ylabel "Contagens"

set xrange [500:1300]
set yrange [0:2000]

# Set step size
set xtics 100
set ytics 250

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

# Plota os dados
plot "patamar.txt" using ($1*25+575):2:(sqrt($2)) with yerrorbars ls 1 title "Dados experimentais"

# Salva o gráfico
set terminal png
set output "patamar.png"
replot

