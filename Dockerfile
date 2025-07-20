FROM nimlang/nim:2.2.4-ubuntu-regular AS builder

WORKDIR /app

COPY . .

RUN nimble build

FROM ubuntu:24.04

WORKDIR /app

# builder から コンパイル済みの実行ファイルのみをコピー
COPY --from=builder /app/TORO_Configs_Enforcer /TORO_Configs_Enforcer

RUN apt-get update && apt-get install libpcre3

# コンテナ起動時に実行するコマンドを指定
CMD ["/TORO_Configs_Enforcer"]
