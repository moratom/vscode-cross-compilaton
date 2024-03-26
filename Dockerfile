ARG DEBIAN_FRONTEND=noninteractive
# Change this to the target container image
FROM arm32v7/ubuntu:latest AS arm-target
# Do nothing here, only used to extract the sysroot
FROM ubuntu:latest
WORKDIR /work

# Install cross-compilation toolchain and CMake
RUN apt-get update && apt-get install -y \
    g++-arm-linux-gnueabihf \
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
COPY --from=arm-target / /opt/sysroots/arm-linux-gnueabihf/

# Environment variables to use the cross-compiler and sysroot
ENV CC=/usr/bin/arm-linux-gnueabihf-gcc \
    CXX=/usr/bin/arm-linux-gnueabihf-g++ \
    SYSROOT=/opt/sysroots/arm-linux-gnueabihf/
