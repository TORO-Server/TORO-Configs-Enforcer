import os, std/strformat

proc getEnvMap*(): seq[(string, string)] =
  var envMap: seq[(string, string)] = @[]
  for key, value in envPairs():
    envMap.add((fmt"[[{key}]]", value))
  return envMap
