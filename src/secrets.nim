import json

proc getEnvKeys(filePath: string): seq[string] =
  try:
    # `to`手続きで seq[string] に変換
    return to(parseFile(filePath), seq[string])
  except JsonParsingError as e:
    raise e

# 置換したい環境変数のキーを配列で定義
let ENV_KEYS*: seq[string] = getEnvKeys("secrets.json")
