SET callsign=NOCALL
SET frequency=144.858M

rtl_fm\rtl_fm.exe -f %frequency% -o 4 -s 48000 | direwolf\direwolf.exe -r 48000 -B 9600 - | direwolf2ssdv\direwolf2ssdv.exe %callsign%
timeout 60
