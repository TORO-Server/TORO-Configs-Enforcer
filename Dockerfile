FROM nimlang/nim:2.2.4-ubuntu-regular AS builder

WORKDIR /app

COPY . .

RUN nimble build -d:release --passL:"-static"

FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache pcre

# builder から コンパイル済みの実行ファイルのみをコピー
COPY --from=builder /app/TORO_Configs_Enforcer /TORO_Configs_Enforcer

# コンテナ起動時に実行するコマンドを指定
CMD ["/TORO_Configs_Enforcer"]
