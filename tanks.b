#!/usr/bin/bc -l

# De tanks X en Y hebben de vorm van een afgeknotte kegel met een hoogte
# van 1m, basis een cirkel van diameter 2m, en als top een cirkel 1m in diameter.
# Dit komt niet precies overeen met het plaatje, maar mijn idee was dat het
# antwoord waarschijnlijk niet zou moeten afhangen van de exacte verhoudingen.
# X staat met de smalle kant naar beneden, Y staat 'rechtop'
pi=3.14159265358979323846
define area_x(h) { width = 1 + h; return pi * width^2 / 4 }
define area_y(h) { width = 2 - h; return pi * width^2 / 4 }
steps = 1000 # het aantal eenheden waarin we een seconde verdelen
height_x = 1 # peil van het watervolume (dus niet hoogte v/d tank)
height_y = 1
tol = .0001 # bij deze inhoud (in m^3) zeggen we dat de tank 'leeg' is
f = .002 # hoeveelheid water (in m^3) die in 1 seconde onder een druk van een waterkolom van 1m hoogte door de afvoer gaat
         # geen idee of dit realistisch is, maar wederom denk ik niet 
         # dat het hierop aankomt (en het lijkt me geen gekke gok)
for (t = 0; height_x > tol && height_y > tol; t++) # seconds
{
  # gebruik een geneste for loop om te voorkomen dat ik voor elke tijdstap
  # een print-opdracht doe (beetje gekke manier, maar goed) 
  for (tt = 0; tt < steps; tt++)
  {
    height_x -= f * height_x / steps / area_x(height_x) # of als d.v.: dh/dt = -f * h / (opp. watervolume)
    height_y -= f * height_y / steps / area_y(height_y) # oftewel (opp. watervolume) * d(log h)/dt = constant
							# we zeggen dus: de druk op het water dat door de afvoer
							# stroomt is evenredig met h, oftewel naarmate de tank
							# verder leegloopt gaat de druk naar nul, en de tank
							# raakt dus nooit echt leeg. op zich is dat best een
							# goede beschrijving van de werkelijkheid, maar om te
							# bepalen welke tank het eerst "leeg" is moet je dus wel
							# een definitie van leeg hebben die uberhaupt voor kan
							# komen. ik zeg hier: 'leeg' betekent volume < 0.1 liter
  }
  print "t: ", t+1, "s  X: ", height_x, "m  Y: ", height_y, "m\n"
}
quit
