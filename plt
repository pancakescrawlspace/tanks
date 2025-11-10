set terminal pdf
set output 'tanks.pdf'
plot 'tanks.output' using 1:2 title 'X' w line lt 1 lc 1 lw 5, \
     'tanks.output' using 1:3 title 'Y' w line lt 1 lc 2 lw 5
