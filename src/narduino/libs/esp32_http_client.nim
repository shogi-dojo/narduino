## Bindings for the ESP32 HTTPClient class (HTTPClient.h).
##
## Reference: https://docs.espressif.com/projects/arduino-esp32/en/latest/api/http_client.html
## Bundled with the ESP32 Arduino core; no extra installation needed.
##
## The class builds its own TCP connection over WiFi, so it needs the station to be
## connected first. Each request runs begin() -> request -> getString() -> end().

import ../api/wstring

{.push header: "HTTPClient.h".}

type
  HTTPClient* {.importcpp: "HTTPClient", byref.} = object
    ## One HTTP request at a time. Call end() before reusing it for another URL.

proc initHTTPClient*(): HTTPClient {.importcpp: "HTTPClient()", constructor.}

proc begin*(h: var HTTPClient, url: cstring): bool {.importcpp: "#.begin(@)".}
  ## Prepares a request to the URL (http:// or https://). Returns false on a bad URL.
proc `end`*(h: var HTTPClient) {.importcpp: "#.end()".}
  ## Closes the connection.
proc setTimeout*(h: var HTTPClient, ms: uint16) {.importcpp: "#.setTimeout(@)".}
  ## Sets the read timeout in milliseconds.
proc addHeader*(h: var HTTPClient, name: cstring, value: cstring) {.importcpp: "#.addHeader(@)".}
  ## Adds a request header.
proc GET*(h: var HTTPClient): cint {.importcpp: "#.GET()".}
  ## Sends GET. Returns the HTTP status code, or a negative error code.
proc POST*(h: var HTTPClient, payload: ptr uint8, size: csize_t): cint {.importcpp: "#.POST(@)".}
  ## Sends POST with the body. Returns the HTTP status code, or a negative error code.
proc sendRequest*(h: var HTTPClient, httpMethod: cstring, payload: ptr uint8, size: csize_t): cint
  {.importcpp: "#.sendRequest(@)".}
  ## Sends any method with an optional body. Returns the status code or a negative error.
proc getString*(h: var HTTPClient): String {.importcpp: "#.getString()".}
  ## The response body, read after the request.
proc getSize*(h: var HTTPClient): cint {.importcpp: "#.getSize()".}
  ## Content-Length of the response, or -1 when unknown.
proc errorToString*(code: cint): String {.importcpp: "HTTPClient::errorToString(@)".}
  ## Text for a negative error code.

{.pop.}
