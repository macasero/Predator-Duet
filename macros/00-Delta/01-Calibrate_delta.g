; Home the effector
G28

; Heat bed to 60C & nozzle to 130C
M104 S150 T0
M190 S60 T0
M109 S150 T0

; Run delta auto-calibration
M291 P"True Bed Levelling (G32). Press OK to continue or CANCEL to abort." S3
;
G32                               ; run bed.g
;
M291 P"Save Delta Calibration?. Press OK to continue or CANCEL to abort." S3
;
M500                            ; Probe the bed, save the height map in a file on the SD card
; =========================================================================================================
