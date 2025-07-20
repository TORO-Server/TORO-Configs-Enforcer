import os
import re
import std/strformat

proc getEnvMap*(): seq[(string, string)] =
  var envMap: seq[(string, string)] = @[]
  for key, value in envPairs():
    if key.match(re".+_.+"):
      envMap.add((fmt"[[{key}]]", value))
  return envMap
