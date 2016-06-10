# ARRS/SSDV image packets decoder

This is a Windows decoder for APRS encoded SSDV image packets.

The APRS/SSDV format is based on the original SSDV format but with a different approach. SSDV is usually transmitted by a 2FSK modulation which can be done only at very low speeds (up to 600baud at maximum). However APRS is able to do 9k6 and its very easy to put an SSDV image into an APRS frame. So images can be sent much faster.
Its also possible to transmit images on the common 1k2 APRS frequency. With help of the APRS-IS its possible to relay images over huge distances. So if a balloon flies around Japan, its possible to receive the images in Europe. No additional network is neccessary. This can be done only at very low duty cycles and with no path attached to the APRS packet.

## Structure of the packet
The APRS-packet has special identifiers: "{{I"

 - { User defined
 - { Experimental
 - I Image

The payload includes a the base91 encoded SSDV packet which is sightly modified. It could look like:

```DK0TU-11 audio level = 22(+36/-21)   [NONE]   |||||||||
[0.4] DK0TU-11>APECAN:{{IRPDHVMKA4A3KZLJt>T,BT<JII[@ffT^ERBHk;kK_w)shPZ$~:?Py(LA"bVY+NytOirkSqsT>^>{;<cdxCD;B9sEwFeyC|O/,IHL{ij#D2G>Guc!y5w#RqCEw)d?nE5@@zH)X4W,4S&RAR6nrX/)Tp)PNPSpN!ZDa<cuG}IF6S=F[t#|(yw=X"abCgcp"%M$ThN&Ipvn=KyD]q`9)w7h=i]&3sY1:0s=9rQ[A^_>};%RJOu%l</l+TKpb=|%{.}nk0"nkAtjGv~"/J
Unknown message type {, BALLOON```

The decoder software decodes base91. The payload is missing the Sync byte, CRC and FEC from its original [SSDV format](https://ukhas.org.uk/guides:ssdv) since its not needed inside the APRS packet. The sofware calculates the CRC for the packet because its needed by the SSDV decoding algorithm on the Habhub server. It also needs the Sync byte attached. The decoded packet is then sent to the SSDV server and imags can be seen [here](http://ssdv.habhub.org).

## Why did we choose APRS?
1. Many hams already having 9k6 TNCs available so there is no need for additional hardware. Everyone can buy a 9k6-TNC and off we go...
2. The packets can be relayed through the APRS-IS. So you actually dont need a special software to send packets to Habhub. You can use UIView, Direwolf or whatever you like for Igating APRS packets to the APRS-IS. In the end we collect the packets from the APRS-IS and send them to Habhub with a special software.

## Usage of the Sofware
First connect your RTL SDR stick to your computer. You have to install the drivers with [Zadig](http://www.rtl-sdr.com/tag/zadig/) before.
First you have to change your own callsign in the ssdv9k6.bat in the first line. The software also needs to know on which frequency it should receive. My RTL SDR is a bit offset so i tune it usually to 144.858M instead of 144.860M. You can change the frequency in the file ssdv9k6.bat. Finally just launch ssdv9k6.bat. Thats it.

## How the software works
The software uses [rtl_sdr](http://sdr.osmocom.org/trac/wiki/rtl-sdr) and [direwolf](https://github.com/wb2osz/direwolf). They work together in pipes which are defined in the ssdv9k6.bat. rtl_sdr demodulates and direwolf decodes the APRS packets. The decoded packets from direwolf are filered by direwolf2ssdv and sent to the SSDV server where the images get visible [here](http://ssdv.habhub.org).

## License
GNUv2




