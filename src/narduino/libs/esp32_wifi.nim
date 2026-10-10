## Bindings for the ESP32 WiFi station API (WiFi.h): the WiFiClass and its global `WiFi`.
##
## Reference: https://docs.espressif.com/projects/arduino-esp32/en/latest/api/wifi.html
## Bundled with the ESP32 Arduino core; no extra installation needed.
##
## Covers station mode, connecting and scanning. Access-point mode and the
## WiFiClient / WiFiServer classes are not bound here.

import ../api/wstring

{.push header: "WiFi.h".}

type
  WiFiClass* {.importcpp: "WiFiClass", byref.} = object
    ## The ESP32 WiFi controller. The core exposes one global, `WiFi`.
  IPAddress* {.importcpp: "IPAddress", byref.} = object
    ## An IPv4 address, as returned by localIP().

var WiFi* {.importc: "WiFi", nodecl.}: WiFiClass

type
  WifiMode* {.importc: "wifi_mode_t", header: "WiFi.h", nodecl.} = distinct cint
    ## The radio mode enum (wifi_mode_t) that WiFi.mode() takes.

const
  WIFI_OFF* = WifiMode(0)
    ## Radio off.
  WIFI_STA* = WifiMode(1)
    ## Station (client) mode.
  WIFI_AP* = WifiMode(2)
    ## Access-point mode.
  WIFI_AP_STA* = WifiMode(3)
    ## Station and access point together.

  WL_NO_SHIELD* = 255'u8
  WL_IDLE_STATUS* = 0'u8
  WL_NO_SSID_AVAIL* = 1'u8
  WL_SCAN_COMPLETED* = 2'u8
  WL_CONNECTED* = 3'u8
  WL_CONNECT_FAILED* = 4'u8
  WL_CONNECTION_LOST* = 5'u8
  WL_DISCONNECTED* = 6'u8

proc mode*(w: var WiFiClass, m: WifiMode): bool {.importcpp: "#.mode(@)".}
  ## Sets the radio mode (WIFI_OFF / WIFI_STA / WIFI_AP / WIFI_AP_STA).
proc status*(w: var WiFiClass): uint8 {.importcpp: "#.status()".}
  ## Connection status, one of the WL_* values.
proc begin*(w: var WiFiClass, ssid: cstring, pass: cstring): uint8 {.importcpp: "#.begin(@)".}
  ## Starts connecting to a network. Use status() to watch it.
proc disconnect*(w: var WiFiClass, wifioff: bool = false, eraseap: bool = false): bool
  {.importcpp: "#.disconnect(@)".}
  ## Disconnects from the network. Pass wifioff to also turn the radio off.
proc reconnect*(w: var WiFiClass): bool {.importcpp: "#.reconnect()".}
  ## Reconnects with the last configured credentials.
proc isConnected*(w: var WiFiClass): bool {.importcpp: "#.isConnected()".}
  ## True when connected to a network.
proc localIP*(w: var WiFiClass): IPAddress {.importcpp: "#.localIP()".}
  ## The station IP address. 0.0.0.0 when not connected.
proc toString*(ip: IPAddress): String {.importcpp: "#.toString()".}
  ## The address as a dotted string.
proc scanNetworks*(w: var WiFiClass): cint {.importcpp: "#.scanNetworks()".}
  ## Blocking scan. Returns the number of networks found, or a negative error.
proc scanDelete*(w: var WiFiClass) {.importcpp: "#.scanDelete()".}
  ## Frees the results of the last scan.
proc SSID*(w: var WiFiClass, i: uint8): String {.importcpp: "#.SSID(@)".}
  ## SSID of scan result i.
proc RSSI*(w: var WiFiClass, i: uint8): cint {.importcpp: "#.RSSI(@)".}
  ## Signal strength of scan result i, in dBm.
proc encryptionType*(w: var WiFiClass, i: uint8): uint8 {.importcpp: "#.encryptionType(@)".}
  ## Encryption type of scan result i (WIFI_AUTH_* values; 0 = open).

{.pop.}
