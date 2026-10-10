## Scan the I2C bus (Wire) on an ESP32-S3 and list the addresses that answer.
##
## Flash with narduino, then open the serial monitor. Each responding address is
## printed as hex, one per line.

import ../src/narduino
import ../src/narduino/libs/wire

setup:
  Serial.begin(115200)
  delay(1000)
  discard Wire.begin()
  Serial.println("I2C scan")

loop:
  var found = 0
  for address in 1'u8 .. 126'u8:
    Wire.beginTransmission(address)
    if Wire.endTransmission() == 0:
      Serial.print("found 0x")
      Serial.println(initString(int(address), 16'u8).c_str())
      inc found
  Serial.print(initString(found).c_str())
  Serial.println(" device(s)")
  delay(5000)
