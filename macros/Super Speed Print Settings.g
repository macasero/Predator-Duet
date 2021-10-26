M203 X42000 Y42000 Z42000 E4200							; Set maximum speeds (mm/min)
M201 X4000 Y4000 Z4000 E3000							; Set accelerations (mm/s^2)
M204 P1500 T4000										; Set printing and travel accelerations
M566 E600						;600	  ; Set maximum instantaneous speed changes (JERKS) (mm/min) ONLY EXTRUDER
M205 X9 Y9 Z9							; Set maximum instantaneous speed changes (JERKS) (mm/seg) XYZ . USE this for Marlin COMPATIBILITY