import asyncdispatch, os, strutils, sequtils, std/strformat

import secret, file

## メイン 非同期処理
proc main() {.async.} =
  try:
    # 置換ルール 生成
    let replace_rule = getEnvKeys("secrets.json").map(
        proc(key: string): (string, string) =
      (fmt"[[{key}]]", getEnv(key, ""))
    )
    # 非同期タスクのリスト
    var tasks: seq[Future[void]]
    # カレントディレクトリ 探索(再帰的)
    for filePath in walkDirRec(getCurrentDir()):
      # ファイル毎に非同期処理タスクを生成してリストに追加
      tasks.add processFile($filePath, replace_rule)
    # すべてのタスクが完了するまで 待機
    await all(tasks)

    echo fmt"(Done) All files processed."
  except Exception as e:
    echo fmt"(ERROR) [Exception] {e.msg}"


# エントリポイント
when isMainModule:
  waitFor main()
