#!/usr/bin/bc -l

# De tanks X en Y hebben de vorm van een afgeknotte kegel met een hoogte
# van 1m, basis een cirkel van diameter 2m, en als top een cirkel 1m in diameter.
# Dit komt niet precies overeen met het plaatje, maar mijn idee was dat het
# antwoord waarschijnlijk niet zou moeten afhangen van de exacte verhoudingen.
# X staat met de smalle kant naar beneden, Y staat 'rechtop'
pi=3.14159265358979323846
define width_x(h) { return 1 + h; }
define width_y(h) { return 2 - h; }
steps = 1000 # het aantal eenheden waarin we een seconde verdelen: 1/steps = "delta_t"
height_x = 1 # peil van het watervolume (dus niet hoogte v/d tank)
height_y = 1
xtol = .0001 # bij dit peil zeggen we dat (voor X) de tank 'leeg' is (voor Y doen we gedeeld door 4, wegens het grotere grondvlak) 
ytol = xtol / 4
f = .002 # hoeveelheid water (in m^3) die in de spanne van een seconde 
         # onder een druk van een waterkolom van 1m hoogte door de afvoer gaat
         # geen idee of dit realistisch is, maar wederom denk ik niet 
         # dat het hierop aankomt (en het lijkt me geen gekke gok)
k = 4 * f / steps / pi # evenredigheidsconstante voor de iteratiestap
                       # de pi / 4 is voor het bepalen van het wateroppervlak
for (t = 0; height_x > xtol && height_y > ytol; t++) # seconds
{
  # gebruik een geneste for loop om te voorkomen dat ik voor elke tijdstap
  # een print-opdracht doe (beetje gekke manier, maar goed) 
  for (tt = 0; tt < steps; tt++)
  {
    height_x *= 1 - k / width_x(height_x)^2 # of als d.v.: dh/dt = -f * h / (opp. watervolume)
    height_y *= 1 - k / width_y(height_y)^2 # oftewel (opp. watervolume) * d(log h)/dt = constant
							# we zeggen dus: de druk op het water dat door de afvoer
							# stroomt is evenredig met h, oftewel naarmate de tank
							# verder leegloopt gaat de druk naar nul, en de tank
							# raakt dus nooit echt leeg. op zich is dat best een
							# goede beschrijving van de werkelijkheid, maar om te
							# bepalen welke tank het eerst "leeg" is moet je dus wel
							# een definitie van leeg hebben die uberhaupt voor kan
							# komen. ik zeg hier: 'leeg' betekent volume < 78cl
  }
  print "t: ", t+1, "s  X: ", height_x, "m  Y: ", height_y, "m\n"
}
quit
