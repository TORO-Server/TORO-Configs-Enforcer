import json

proc getEnvKeys*(filePath: string): seq[string] =
  try:
    # `to`手続きで seq[string] に変換
    return to(parseFile(filePath), seq[string])
  except JsonParsingError as e:
    raise e
