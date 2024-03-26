# Change this to the target container image
FROM arm64v8/ubuntu:latest AS arm-target
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /src
# Install the build dependencies for the target, so the sysroot has all the headers
RUN apt-get update && apt-get install -y \
    build-essential \
    libopencv-dev

ARG DEBIAN_FRONTEND=noninteractive
FROM ubuntu:latest AS dev
WORKDIR /work

# Install cross-compilation toolchain and CMake
RUN apt-get update && apt-get install -y \
    g++-10-aarch64-linux-gnu \
    gdb-multiarch \
    cmake \
    git \
    bash-completion \
    sudo


# Create and switch to a default user with sudo capabilities
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN sed -i '/^%sudo/d' /etc/sudoers
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy the sysroot into the image
COPY --from=arm-target / /opt/sysroots/aarch64-linux-gnu/
COPY toolchains/ArmCrossCompile.cmake /opt/toolchains/ArmCrossCompile.cmake
# Environment variables to use the cross-compiler and sysroot
ENV CC=/usr/bin/aarch64-linux-gnu-gcc-10 \
    CXX=/usr/bin/aarch64-linux-gnu-g++-10 \
    SYSROOT=/opt/sysroots/aarch64-linux-gnu/ \
    CMAKE_TOOLCHAIN_FILE=/opt/toolchains/ArmCrossCompile.cmake
