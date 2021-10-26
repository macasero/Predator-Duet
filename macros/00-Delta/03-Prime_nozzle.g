; Filament gcode
G92 E0 ; reset extrusion distance

G1 X0 Y-188 Z1.5 F9000 ; move to arc start
G3 X188 Y0 R188 Z0.5 E50 F500 ; lay arc stripe 90deg

G92 E0 ; reset extrusion distance
G1 Z5 E0 F3000 ; get off the bed