; homeall.g
; Called to home all towers on a delta printer

; Home all towers
M290 R0 S0											; Reset baby-stepping to 0
M913 X100 Y100 Z100                                 ; Set motors to 100%
G91												    ; Use relative positioning
G1 X750 Y750 Z750 F9000 H1							; Move all towers to the high end stopping at the endstops (first pass)
G1 X-5 Y-5 Z-5 F500 H2								; Go down a few mm
G1 X10 Y10 Z10 F500 H1								; Move all towers up once more (second pass)
G1 X-5 Y-5 Z-5 F500 H2								; Go down a few mm
G1 Z-5 F6000               ; move down a few mm so that the nozzle can be centred
G90                        ; absolute positioning
G1 X0 Y0 F6000             ; move X+Y to the centre