# Carrega os dados
set fit errorvariables
set title "Espectro de emissão do ^{241}Am"
set xlabel "Canal"
set ylabel "Contagens"

set key top left

set xrange [400:510]
set yrange [40:50000]

# Set step size
set xtics 10
set ytics 1000

# Set subdivide
set mxtics 5
set mytics 5

# Remove ticks from top and right only
set xtics nomirror
set ytics nomirror

# Set graph color to blac
set style line 1 lc rgb 'black' pt 7 ps 0.7 # Pontos pretos

x0 = 440
x1 = 455
x2 = 465
x3 = 485

# Fit gaussian 1
f1(x) = a1*exp(-((x-b1)/c1)**2)
a1 = 8000
b1 = 470
c1 = 10

fit [x0:x1] f1(x) "AM200S.txt" skip 5 using 1:2:(sqrt($2)>0 ? sqrt($2) : 1) yerrors via a1,b1,c1

# Fit gaussian 2
f2(x) = a2*exp(-((x-b2)/c2)**2)
a2 = 8000
b2 = 480
c2 = 10

# Fit gaussian 3
f3(x) = a3*exp(-((x-b3)/c3)**2)
a3 = 8000
b3 = 420
c3 = 10

# Fit gaussian 4
f4(x) = a4*exp(-((x-b4)/c4)**2)
a4 = 50
b4 = 500
c4 = 10

x4 = 400
x5 = 430
x6 = 492
x7 = 510

fit [x4:x5] f3(x) "AM200S.txt" skip 5 using 1:2:(sqrt($2)>0 ? sqrt($2) : 1) yerrors via a3,b3,c3
fit [x2:x3] f2(x) "AM200S.txt" skip 5 using 1:2:(sqrt($2)>0 ? sqrt($2) : 1) yerrors via a2,b2,c2
fit [x6:x7] f4(x) "AM200S.txt" skip 5 using 1:2:(sqrt($2)>0 ? sqrt($2) : 1) yerrors via a4,b4,c4

fit f1(x)+f2(x)+f3(x)+f4(x) "AM200S.txt" skip 5 using 1:2:(sqrt($2)>0 ? sqrt($2) : 1) yerrors via a2,b2,c2,a1,b1,c1,a3,b3,c3,a4,b4,c4

set arrow from b3,40 to b3,a3*1.9 head
set arrow from b2,40 to b2,a2*1.9 head
set arrow from b1,40 to b1,a1*1.9 head
set arrow from b4,40 to b4,a4*1.9 head
set label at b1,a1*2.3 center sprintf("$%.1f$", b1)
set label at b2,a2*2.3 center sprintf("$%.1f$", b2)
set label at b3,a3*2.3 center sprintf("$%.1f$", b3)
set label at b4,a4*2.3 center sprintf("$%.1f$", b4)

set label at 485, 10000 sprintf("$\\\sfrac{\\chi^2}{n_{df}} =%.2f$", FIT_WSSR/FIT_NDF)
set logscale y
# Plot data
plot "AM200S.txt" skip 5 using 1:2:(sqrt($2)>0 ? sqrt($2) : 1) with yerrorbars ls 1 title "Dados", \
     f3(x) ls 11 lw 3 notitle , \
     f1(x) ls 7 lw 3 notitle , \
     f2(x) ls 9 lw 3 notitle , \
     f4(x) ls 12 lw 3 notitle , \
     f1(x) + f2(x) + f3(x)+ f4(x) ls 2 lw 5 notitle


# Print a1 asymptotic standard error
print "a1 error: ", a1_err
