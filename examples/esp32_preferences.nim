## Store and read back settings in NVS with Preferences on an ESP32-S3.
##
## Each run increments a boot counter and stores a string, then prints both. The
## values survive resets, which makes this a quick check that NVS works on the board.

import ../src/narduino
import ../src/narduino/libs/esp32_preferences

setup:
  Serial.begin(115200)
  delay(1000)
  var prefs = initPreferences()
  if prefs.begin("example"):
    let boots = prefs.getInt("boots", 0) + 1
    discard prefs.putInt("boots", boots)
    discard prefs.putString("label", "smart compass")
    var buf: array[32, char]
    let n = prefs.getString("label", addr buf[0], buf.len.csize_t)
    let label = prefs.getString("label")
    Serial.print("boots: ")
    Serial.println(initString(boots).c_str())
    Serial.print("label (")
    Serial.print(initString(int(n)).c_str())
    Serial.print(" bytes): ")
    Serial.println(label.c_str())
    prefs.`end`()
  else:
    Serial.println("could not open the preferences namespace")

loop:
  delay(60000)
