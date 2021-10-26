; resume.g
; called before a print from SD card is resumed
M83                  	                  ; relative extruder moves
G1 R1 X0 Y0 Z60 F6000                     ; go to 15mm above position of the last print move
G1 E5 F3600                               ; extrude 5mm of filament
M291 S3 R"RESUME!!!!" P"Clean Nozzle NOW!!!! then press OK"
G1 R1 X0 Y0                               ; go back to the last print move
M121										; Recover the last state pushed onto the stack
