FROM ubuntu:24.04

ARG NFSCHEMA_VERSION="@2.0.1"
ARG NFAMAZON_VERSION="@2.6.0"
ARG NFCODECOMMIT_VERSION="@0.1.5-patch1"
ARG NFTOWER_VERSION="@1.6.3-patch1"
ARG NFCONSOLE_VERSION="@1.1.3"
ARG CO2FOOTPRINT_VERSION="@1.0.0-beta"
# ARG NFCORE_VERSION="@2.14.1"
ARG JAVA_VERSION="21"

RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        curl \
        tar \
        gzip \
        "openjdk-${JAVA_VERSION}-jdk" \
        procps \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/* \
    && curl -s https://get.nextflow.io | bash \
    && chmod +x nextflow \
    && mv nextflow /usr/local/bin

RUN nextflow plugin install "nf-schema${NFSCHEMA_VERSION}"
RUN nextflow plugin install "nf-amazon${NFAMAZON_VERSION}"
RUN nextflow plugin install "nf-codecommit${NFCODECOMMIT_VERSION}"
RUN nextflow plugin install "nf-tower${NFTOWER_VERSION}"
RUN nextflow plugin install "nf-console${NFCONSOLE_VERSION}"
RUN nextflow plugin install "nf-co2footprint${CO2FOOTPRINT_VERSION}"

ENV NXF_OFFLINE='true'

