ARG GO_VERSION
FROM golang:${GO_VERSION:-1} AS builder

ARG GPHOTOS_UPLOADER_CLI_VERSION="5.0.1"

ENV GOOS=linux \
    GOARCH=amd64

WORKDIR /build

RUN git clone https://github.com/gphotosuploader/gphotos-uploader-cli.git \
        --branch v${GPHOTOS_UPLOADER_CLI_VERSION} \
        --single-branch && \
    cd gphotos-uploader-cli && \
    make build VERSION="${GPHOTOS_UPLOADER_CLI_VERSION}-docker"

FROM debian:latest

#LABEL maintainer="master@ricardoamaral.net"
#
#ARG BUILD_DATE
#ARG S6_OVERLAY_VERSION
#ARG VCS_REF
#
#LABEL \
#    org.label-schema.build-date="${BUILD_DATE}" \
#    org.label-schema.description="Mass upload media folders to your Google Photos account with this Docker image." \
#    org.label-schema.name="rfgamaral/gphotos-uploader" \
#    org.label-schema.schema-version="1.0" \
#    org.label-schema.vcs-ref="${VCS_REF}" \
#    org.label-schema.vcs-url="https://github.com/rfgamaral/docker-gphotos-uploader.git"
#

RUN apt-get update && apt-get install -y ca-certificates

COPY --from=builder /build/gphotos-uploader-cli/gphotos-uploader-cli /usr/local/bin/

VOLUME ["/config", "/photos"]

ENTRYPOINT ["gphotos-uploader-cli", "--config", "/config"]

CMD ["--help"]
