; bed.g
; called to perform automatic delta calibration via G32
;
; Auto calibration routine for large delta printer
M561                    ; clear any bed transform

; If the printer hasn't been homed, home it and don´t go down
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
 M290 R0 S0											; Reset baby-stepping to 0
 M913 X100 Y100 Z100                                 ; Set motors to 100%
 G91												    ; Use relative positioning
 G1 X750 Y750 Z750 F9000 H1							; Move all towers to the high end stopping at the endstops (first pass)
 G1 X-5 Y-5 Z-5 F500 H2								; Go down a few mm
 G1 X10 Y10 Z10 F500 H1								; Move all towers up once more (second pass)
 G90			
; Probe the bed and do auto calibration
M558 F400 A5 S0.02
G1 X0 Y169.9 Z10 F16000
while true
 if iterations > 5
  abort "Too many auto calibration attempts"
 G30 P0 X0 Y169.9 H0 Z-99999
 if result != 0
  continue
 G30 P1 X147.14 Y84.95 H0 Z-99999
 if result != 0
  continue
 G30 P2 X147.14 Y-84.95 H0 Z-99999
 if result != 0
  continue
 G30 P3 X0 Y-169.9 H0 Z-99999
 if result != 0
  continue
 G30 P4 X-147.14 Y-84.95 H0 Z-99999
 if result != 0
  continue
 G30 P5 X-147.14 Y84.95 H0 Z-99999
 if result != 0
  continue
 G30 P6 X0 Y84.9 H0 Z-99999
 if result != 0
  continue
 G30 P7 X73.53 Y42.45 H0 Z-99999
 if result != 0
    continue
 G30 P8 X73.53 Y-42.45 H0 Z-99999
 if result != 0
  continue
 G30 P9 X0 Y-84.9 H0 Z-99999
 if result != 0
    continue
 G30 P10 X-73.53 Y-42.45 H0 Z-99999
 if result != 0
  continue
 G30 P11 X-73.53 Y42.45 H0 Z-99999
 if result != 0
  continue
 G30 P12 X0 Y0 H0 Z-99999 S6
 if result != 0
  continue
 if move.calibration.final.deviation <= 0.03
  break
 echo "Repeating 'cause dev too high (" ^ move.calibration.final.deviation ^ " mm)"
; end loop
echo "Auto calibration successful, deviation "^ move.calibration.final.deviation ^ "mm"
G1 X0 Y0 Z150 F16000                ; get the head out of the way