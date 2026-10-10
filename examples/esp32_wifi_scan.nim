## List the WiFi networks in range on an ESP32-S3, with signal strength and security.

import ../src/narduino
import ../src/narduino/libs/esp32_wifi

setup:
  Serial.begin(115200)
  delay(1000)
  discard WiFi.mode(WIFI_STA)
  discard WiFi.disconnect()
  delay(100)

loop:
  let count = WiFi.scanNetworks()
  Serial.print(initString(count).c_str())
  Serial.println(" network(s)")
  for i in 0 ..< count:
    let index = uint8(i)
    Serial.print(WiFi.SSID(index).c_str())
    Serial.print("  ")
    Serial.print(initString(WiFi.RSSI(index)).c_str())
    Serial.print(" dBm  ")
    Serial.println(if WiFi.encryptionType(index) == 0: "open" else: "secured")
  WiFi.scanDelete()
  delay(10000)
