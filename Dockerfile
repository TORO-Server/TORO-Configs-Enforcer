FROM nimlang/nim:2.2.4-ubuntu-regular AS builder

WORKDIR /app

COPY . .

RUN nimble build -d:release --passL:"-static"

FROM debian:12-slim

WORKDIR /app

COPY --from=builder /app/TORO_Configs_Enforcer /TORO_Configs_Enforcer

RUN apt-get update && apt-get install libpcre3

CMD ["/TORO_Configs_Enforcer"]