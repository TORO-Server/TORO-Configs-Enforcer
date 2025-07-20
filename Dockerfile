FROM nimlang/nim:2.2.4-ubuntu-regular AS builder

WORKDIR /app

COPY . .

RUN nimble build -d:release

FROM debian:12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends libpcre3 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/TORO_Configs_Enforcer /TORO_Configs_Enforcer

CMD ["/TORO_Configs_Enforcer"]