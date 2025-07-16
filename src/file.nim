import asyncdispatch, os, strutils, std/strformat, re

## 非同期でファイル 処理
proc processFile*(filePath: string, rep_rule: seq[(string, string)]) {.async.} =
  let (dirPath, fileName) = splitPath(filePath)
  if ($fileName).contains(re(r"\.pub\.*")):
    try:
      # ファイル 読み込み
      var content = readFile($filePath)
      # ファイル内容 置換
      content = content.multiReplace(rep_rule)
      # 新しいファイル名(".pub" を削除) 生成
      let newFilename = filename.replace(re(r"\.pub\.*"), r".")
      let newFilePath = dirPath / newFilename
      # 置換後のファイル内容 書き込み
      writeFile(newFilePath, content)

      echo fmt"(OK) {filePath} -> {newFilePath}"
    except IOError as e:
      echo fmt"(ERROR) [IOError] {e.msg}"
    except Exception as e:
      echo fmt"(ERROR) [Exception] {e.msg}"
