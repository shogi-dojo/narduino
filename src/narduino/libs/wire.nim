## Bindings for the Arduino Wire (I2C) library: the TwoWire class and its global `Wire`.
##
## Reference: https://docs.arduino.cc/language-reference/en/functions/communication/wire/
## Bundled with the ESP32 Arduino core (Wire.h); no extra installation needed.
##
## Note on bus ownership: `begin()` is bound for completeness, but a sketch that
## shares the bus across drivers should initialise it once and let the rest reuse it.
## Calling begin() again resets the peripheral, and that breaks the other devices.

{.push header: "Wire.h".}

type
  TwoWire* {.importcpp: "TwoWire", byref.} = object
    ## The I2C bus controller. The ESP32 core exposes one global, `Wire`.

var Wire* {.importc: "Wire", nodecl.}: TwoWire

proc begin*(w: var TwoWire): bool {.importcpp: "#.begin()".}
  ## Starts the bus on the default pins. Call once per bus.
proc begin*(w: var TwoWire, sda: cint, scl: cint): bool {.importcpp: "#.begin(@)".}
  ## Starts the bus on the given SDA and SCL pins.
proc setClock*(w: var TwoWire, freq: uint32) {.importcpp: "#.setClock(@)".}
  ## Sets the bus clock frequency in Hz.
proc setTimeOut*(w: var TwoWire, ms: uint16) {.importcpp: "#.setTimeOut(@)".}
  ## Sets the timeout for blocking transfers, in milliseconds.
proc beginTransmission*(w: var TwoWire, address: uint8) {.importcpp: "#.beginTransmission(@)".}
  ## Begins a write transaction to the device at the 7-bit address.
proc write*(w: var TwoWire, value: uint8): csize_t {.importcpp: "#.write(@)".}
  ## Queues one byte for the open write transaction.
proc endTransmission*(w: var TwoWire, sendStop: bool = true): uint8 {.importcpp: "#.endTransmission(@)".}
  ## Sends the queued bytes. 0 means success; other values are error codes.
proc requestFrom*(w: var TwoWire, address: uint8, quantity: uint8, sendStop: bool = true): uint8
  {.importcpp: "#.requestFrom(@)".}
  ## Requests `quantity` bytes from the device. Returns the number of bytes received.
proc available*(w: var TwoWire): cint {.importcpp: "#.available()".}
  ## Number of bytes waiting to be read.
proc read*(w: var TwoWire): cint {.importcpp: "#.read()".}
  ## Next byte from the receive buffer, or -1 if it's empty.

{.pop.}
