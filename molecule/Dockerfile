FROM debian:13-slim

# hadolint ignore=DL3008,DL3009
RUN --mount=type=cache,id=debian_13_lists,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=cache,id=debian_13_archives,target=/var/cache/apt/archives,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
 && apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates python3 python3-apt sudo
