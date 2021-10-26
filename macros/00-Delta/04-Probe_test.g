M291 P"Probe will be tested 10 times and return mean and standard deviation. Ok or Cancel?" R"WARNING" S3 ; User must click OK or cancel.
M561                    ; clear any bed transform

; If the printer hasn't been homed, home it and don´t go down
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
 G28
M401
G30 P0 X0 Y0 Z-9999
G30 P1 X0 Y0 Z-9999
G30 P2 X0 Y0 Z-9999
G30 P3 X0 Y0 Z-9999
G30 P4 X0 Y0 Z-9999
G30 P5 X0 Y0 Z-9999
G30 P6 X0 Y0 Z-9999
G30 P7 X0 Y0 Z-9999
G30 P8 X0 Y0 Z-9999
G30 P9 X0 Y0 Z-9999 S-1
M402