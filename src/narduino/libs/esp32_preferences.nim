## Bindings for the ESP32 Preferences class (Preferences.h): key-value storage in NVS.
##
## Reference: https://docs.espressif.com/projects/arduino-esp32/en/latest/api/preferences.html
## Bundled with the ESP32 Arduino core; no extra installation needed.
##
## Each open/use/close is a namespace session: begin(name, readOnly), operate, end().
## Strings are read into a caller-owned buffer, so no heap String is needed.

import ../api/wstring

{.push header: "Preferences.h".}

type
  Preferences* {.importcpp: "Preferences", byref.} = object
    ## One storage namespace. Open it with begin() and close it with end().

proc initPreferences*(): Preferences {.importcpp: "Preferences()", constructor.}

proc begin*(p: var Preferences, name: cstring, readOnly: bool = false): bool
  {.importcpp: "#.begin(@)".}
  ## Opens (creating if needed) the namespace. readOnly skips write access.
proc `end`*(p: var Preferences) {.importcpp: "#.end()".}
  ## Closes the namespace.
proc putString*(p: var Preferences, key: cstring, value: cstring): csize_t {.importcpp: "#.putString(@)".}
  ## Stores a string. Returns the number of bytes written, or 0 on failure.
proc getString*(p: var Preferences, key: cstring, value: ptr char, maxLen: csize_t): csize_t
  {.importcpp: "#.getString(@)".}
  ## Reads a string into a caller-owned buffer of maxLen bytes, NUL-terminated.
  ## Returns the length, or 0 if missing. Pass `addr buf[0]` and `buf.len`.
proc getString*(p: var Preferences, key: cstring, defaultValue: cstring = ""): String
  {.importcpp: "#.getString(@)".}
  ## Reads a string as an Arduino String, or the default when the key is missing.
proc putInt*(p: var Preferences, key: cstring, value: int32): csize_t {.importcpp: "#.putInt(@)".}
  ## Stores a 32-bit integer.
proc getInt*(p: var Preferences, key: cstring, defaultValue: int32 = 0): int32
  {.importcpp: "#.getInt(@)".}
  ## Reads a 32-bit integer, or the default when the key is missing.
proc remove*(p: var Preferences, key: cstring): bool {.importcpp: "#.remove(@)".}
  ## Removes a key. Returns true if it existed.
proc isKey*(p: var Preferences, key: cstring): bool {.importcpp: "#.isKey(@)".}
  ## True when the key exists in the namespace.
proc clear*(p: var Preferences): bool {.importcpp: "#.clear()".}
  ## Removes every key in the namespace.

{.pop.}
