M291 P"Probe will be tested 10 times and return Z-offset value for your G31 in config. Ok or Cancel?" R"WARNING" S3 ; User must click OK or cancel.
M561                    ; clear any bed transform

; If the printer hasn't been homed, home it and don´t go down
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
 G28
G1 Z10 F10000
G30
G30 S-1
G1 Z5
G30 S-1
G1 Z5
G30 S-1
G1 Z5
G30 S-1
G1 Z5
G30 S-1
G1 Z5
G30 S-1
G1 Z5