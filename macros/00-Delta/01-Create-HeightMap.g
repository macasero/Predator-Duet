; =========================================================================================================
; Test Routine for Duet WiFi
; Part of self check
;
; =========================================================================================================
;
M291 P"Creating initial height map. Press OK to continue or CANCEL to abort." S3
;

M561                    ; clear any bed transform
; If the printer hasn't been homed, home it and don´t go down
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
 G28
 G1 Z10 F6000
; Probe the bed and do auto calibration
G30
G29 S0                            ; Probe the bed, save the height map in a file on the SD card
;
; =========================================================================================================
