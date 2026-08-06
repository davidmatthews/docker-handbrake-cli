# -------- Build stage --------
FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    libtool-bin \
    pkg-config \
    python3 \
    python3-pip \
    git \
    nasm \
    yasm \
    gettext \
    meson \
    ninja-build \
    cmake \
    rustc \
    cargo \
    libnuma-dev \
    libmp3lame-dev \
    libopus-dev \
    libspeex-dev \
    libvpx-dev \
    libjansson-dev \
    libx264-dev \
    libtheora-dev \
    libvorbis-dev \
    libturbojpeg-dev \
    libass-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# The workflow resolves this to the newest stable HandBrake release.
ARG HANDBRAKE_VERSION=""

# Clone the HandBrake source repository and fetch its release tags.
RUN git clone https://github.com/HandBrake/HandBrake.git \
    && cd HandBrake \
    && git fetch --tags
WORKDIR /build/HandBrake

# Checkout the stable release selected by the workflow, or resolve the newest
# stable release when the build argument was omitted.
RUN version="${HANDBRAKE_VERSION}" \
    && if test -z "${version}"; then \
         version="$(git tag -l | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)"; \
       fi \
    && test -n "${version}" \
    && git checkout "${version}"

# Build
RUN ./configure --disable-gtk --launch-jobs=$(nproc) --launch

# Verify build
RUN ./build/HandBrakeCLI --version

# -------- Runtime stage --------
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libstdc++6 \
    libgcc-s1 \
    libnuma1 \
    libass9 \
    libbz2-1.0 \
    libz1 \
    libvpx9 \
    libx264-164 \
    libopus0 \
    libmp3lame0 \
    libvorbis0a \
    libvorbisenc2 \
    libtheora0 \
    libjansson4 \
    libturbojpeg \
    libspeex1 \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Copy HandBrake binary
COPY --from=builder /build/HandBrake/build/HandBrakeCLI /usr/local/bin/HandBrakeCLI

# Verify installation
RUN HandBrakeCLI --version

ENTRYPOINT ["HandBrakeCLI"]
