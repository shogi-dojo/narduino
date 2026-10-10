## Join a WiFi network on an ESP32-S3 and fetch a URL with HTTPClient.
##
## Set `ssid`, `password` and `url` below before flashing. The example prints the
## HTTP status and the response length, and fails loudly if WiFi never connects.

import ../src/narduino
import ../src/narduino/libs/esp32_wifi
import ../src/narduino/libs/esp32_http_client

const
  ssid = cstring "your-network"
  password = cstring "your-password"
  url = cstring "https://example.com/"

setup:
  Serial.begin(115200)
  delay(1000)
  discard WiFi.mode(WIFI_STA)
  while WiFi.begin(ssid, password) != WL_CONNECTED:
    Serial.println("connecting...")
    delay(2000)
  Serial.println("connected")

loop:
  var http = initHTTPClient()
  http.setTimeout(10000)
  if not http.begin(url):
    Serial.println("bad url")
  else:
    http.addHeader("Accept", "application/json")
    let code = http.GET()
    if code > 0:
      let body = http.getString()
      Serial.print("status ")
      Serial.print(initString(code).c_str())
      Serial.print(", ")
      Serial.print(initString(body.len).c_str())
      Serial.println(" bytes")
    else:
      Serial.print("request failed: ")
      Serial.println(errorToString(code).c_str())
    http.`end`()
  delay(30000)
