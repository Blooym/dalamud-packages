ARG DOTNET_SDK

FROM alpine AS builder
WORKDIR /build
ARG DALAMUD_URL
RUN apk add --no-cache wget unzip \
    && wget -O dalamud.zip "${DALAMUD_URL}" \
    && unzip dalamud.zip -d dalamud

FROM mcr.microsoft.com/dotnet/${DOTNET_SDK}
ENV DALAMUD_HOME=/usr/lib/dalamud
COPY --from=builder /build/dalamud/ ${DALAMUD_HOME}/