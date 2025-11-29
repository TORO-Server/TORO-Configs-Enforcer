import asyncdispatch, os, strutils, std/strformat, re, checksums/sha1

## 非同期でファイル 処理
proc processFile*(filePath: string, rep_rule: seq[(string, string)]) {.async.} =
  let (dirPath, fileName) = splitPath(filePath)
  if ($fileName).contains(re(r"\.pub\.*")):
    try:
      # ファイル内容 読み込み 置換
      let newContent = readFile($filePath).multiReplace(rep_rule)
      # 新しいファイル名(".pub" を削除) 生成
      let newFilename = filename.replace(re(r"\.pub\.*"), r".")
      let newFilePath = dirPath / newFilename

      if fileExists(newFilePath):
        let newHash = $secureHash(newContent)
        let existingContent = readFile(newFilePath)
        let existingHash = $secureHash(existingContent)

        if newHash == existingHash:
          echo fmt"(SKIP) {newFilePath} : Checksum matches ({newHash})"
          return

      # 置換後のファイル内容 書き込み
      writeFile(newFilePath, newContent)
      echo fmt"(OK) {filePath} -> {newFilePath} : Written"

    except IOError as e:
      echo fmt"(ERROR) [IOError] {e.msg}"
    except Exception as e:
      echo fmt"(ERROR) [Exception] {e.msg}"
