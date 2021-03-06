; config.g
; Called on power-up of the Duet Electronics

; General preferences
G90										; Send absolute coordinates...
M83										; ...but relative extruder moves

; Network
M550 P"Predator"							; Set machine name
M552 S1 P192.168.0.24
M553 P255.255.255.0
M554 P192.168.0.1
M586 P0 S1									; Enable HTTP
M586 P1 S0 ;C"*"									; Allow FTP and Cross Origin Resource Sharing (CORS)for DueUI
M586 P2 S0									; Disable Telnet

; Delta Settings v6
;M665 L440.833:440.833:440.833 R228.023 H419.445 B185.0 X0.087 Y0.037 Z0.000
;M666 X-0.381 Y0.083 Z0.298 A0.00 B0.00
M665 L440.833:440.833:440.833 R234.928 H413.488 B190.0 X0.033 Y-0.095 Z0.000
M666 X-0.152 Y-0.112 Z0.264 A0.00 B0.00


; Drives direction
M569 P0 S0									; Drive 0 goes backwards
M569 P1 S0									; Drive 1 goes backwards
M569 P2 S0									; Drive 2 goes backwards
M569 P3 S0									; Drive 3 goes forwards
M584 X0 Y1 Z2 E3                            ; Map drivers
; Steps
M350 X16 Y16 Z16 I1								; Configure micro-stepping with interpolation for X, Y, Z 
M350 E16 I1								; Configure micro-stepping with interpolation for E
M92 X80 Y80 Z80 E415								; Set steps per mm
; Speed, Acc and Jerks
M203 X36000 Y36000 Z36000 E4200							; Set maximum speeds (mm/min)
M201 X4000 Y4000 Z4000 E3000							; Set accelerations (mm/s^2)
M204 P1000 T4000										; Set printing and travel accelerations
M566 E600						;600	  ; Set maximum instantaneous speed changes (JERKS) (mm/min) ONLY EXTRUDER
M205 X8 Y8 Z8							; Set maximum instantaneous speed changes (JERKS) (mm/seg) XYZ . USE this for Marlin COMPATIBILITY
; Stepper Current
M906 X1250 Y1250 Z1250 E500 I30							; Set motor currents (mA) and motor idle factor in per cent
M84 S30														; Set idle timeout

; Axis Limits
M208 Z-1 S1									; Set minimum Z

; Endstops
M574 X2 S1 P"xstop"								; Set active high endstop on X on pin xstop
M574 Y2 S1 P"ystop"								; Set active high endstop on Y on pin ystop
M574 Z2 S1 P"zstop"								; Set active high endstop on Z on pin zstop


; =========================================================================================================
;  filament handling
; =========================================================================================================
;
; execute macros that has the status of the filament sensor
;
M98 P"0:/sys/00-Functions/FilamentsensorStatus"
;
; =========================================================================================================


; ZProbe
M558 P8 R0.4 C"zprobe.in+zprobe.mod" H5 F900:450 T9000 ;A3 S0.03    ; set Z probe type to effector and the dive height + speeds
G31 K0 P500 X0.0 Y0.0 Z-0.26                               ; set Z probe trigger value, offset and trigger
M557 R170 S25									; Define mesh grid

; Heaters
; Heated Bed
M308 S0 P"bedtemp" Y"thermistor"  T100000 B3950 C0 R4700 A"Bed"			; Define Sensor0 as the heated bed temperature TRY B4300
M950 H0 C"bedheat" T0								; Define Heater0 as the heated bed, bind to Sensor0				; PID M950 H0 C"bedheat" T0								; Define Heater0 as the heated bed, bind to Sensor0				; PID 
M140 H0                                                   ; map heated bed to heater 0
M143 H0 P0 S120 A2                                      ; disable temporarily H0 if temp exceeds 120C
M143 H0 P0 S130 A0                                      ; heater fault H0 if temp exceeds 130C
M307 H0 B0 S1.00                                     ; disable bang-bang mode for the bed heater and set PWM limit
M570 H0 P60 T15 S0                                      ; heater fault for 60seg of 15??C excursion

; Hotend1
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.06e-8 A"Hotend"				; Define Sensor1 as Extruder0 temperature
M950 H1 C"e0heat" T1								; Define Heater1 as Extruder0 heater, bind to Sensor1
M143 H1 S275 A2                                         ; disable temporarily H1 if temp exceeds 275C
M143 H1 S285 A0                                         ; heater fault H1 if temp exceeds 280C
M307 H1 B0 S1.00                                        ; disable bang-bang mode for heater  and set PWM limit
M570 H1 P10 T30 S0                                      ; heater fault for 10 seg of 30??C excursion

; Heater model parameters
M307 H0 R0.424 C339.976:339.976 D1.51 S1.00 V24.6 B0
M307 H1 R2.147 C268.6 D10.79 S1.00 V24.5

; Fan0 = Part Coooling
M950 F0 C"fan0" Q160								; Define Fan0 for Part Cooling (2x Delta BFB0412HHA-A), 500Hz PWM
M106 P0 S0 H-1									; Set Fan0 to default off, manual control

; Fan1 = Hotend
M950 F1 C"fan1" Q500								; Define Fan1 for Hotend cooling, 500Hz PWM
M106 P1 S1 H1 T45								; Set Fan1 to Thermostatic control, max RPM at 45C

; Fan2 = MotherBoard Cooling
;----MCU & DRIVERS sensors------
M308 S3 Y"mcu-temp"	A"MCU"								; create sensor for MCU temp M308 S3 Y"mcutemp"
M308 S4 Y"drivers"	A"Drivers"							; create sensor for drivers temp M308 S4 Y"drivers"
M912 P0 S-0.8                                           ; Calibrate MCU temp
M950 F2 C"fan2" Q500									; create fan 2 on pin out4 - alternative with tacho M950 F2 C"!fan2+^pb6"
M106 P2 H3:4 L.3 B.5 X1 T40:65 					; Set fan 2 PWR fan. Turns on when MCU temperature, hits 45C and full when the MCU temperature reaches 65C or any TMC2660 alarms

; Tools
M200 D1.75
M563 P0 S"T0" D0 H1 F0                                  ; define tool 0
G10 P0 X0 Y0 Z0									; Set tool 0 axis offsets
G10 P0 S-274 R-274  									; Set initial tool 0 active and standby temperatures to 0C
M302 S180 R180                                         ; allow extrusion starting from 180??C and retractions already from 180??C


; Additional Settings
M404 N1.75									; Define filament diameter for print monitor
M207 S0.85 R0 F2400 Z0								; Firmware retraction
M592 D0 A0.00458969993360082 B0.000458590610785138  ;PETG @235??C 0.6 nozzle
M572 D0 S0.11									; Pressure Advance

; LCD
M575 P1 S0 B57600								; Set Baudrate to 57600

; LED??s life
M950 S0 C"^exp.heater3"                                 ; Leds life


; Miscellaneous
;G29 S1										; Load bed mesh
;M376 H4									; Mesh bed compensation. Height must be set to at least 20x the maximum error in the height map (max 5%)
M911 S23 R24 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"      ; set voltage thresholds and actions to run on power loss
T0										; Select first tool (Extruder 0)
M501

M302 S180 R180                                         ; allow extrusion starting from 180??C and retractions already from 180??C