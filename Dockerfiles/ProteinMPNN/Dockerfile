# Init by using: docker build -t linkrw12/ProteinMPNN:1.0.1 .

# Use NVIDIA CUDA base image with Ubuntu backend
FROM nvcr.io/nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# 
# RUN apt clean && apt update && apt install ca-certificates

RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker

# Clean any existing APT cache before proceeding
# RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /var/cache/apt/archives/partial/* /var/cache/apt/*.bin || true

# Disable the problematic APT post-invoke script
# RUN echo 'APT::Update::Post-Invoke-Success { "true"; };' > /etc/apt/apt.conf.d/no-cache-clean

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y git \
    software-properties-common \
    git \
    curl \
    build-essential \
    libssl-dev \
    libffi-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    zlib1g-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*


# RUN apt-get update

# Add the deadsnakes PPA to install Python 3.12
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev python3-pip

# Set Python 3.12 as the default version
RUN update-alternatives --install /usr/local/bin/python3 python3 /usr/bin/python3.12 1 && \
    update-alternatives --install /usr/local/bin/pip3 pip3 /usr/bin/pip3 1

# Clone ProteinMPNN repo (v1.0.1)
RUN git clone --depth 1 --branch v1.0.1 https://github.com/dauparas/ProteinMPNN.git

# Install ProteinMPNN dependencies
RUN pip3 install \
    torch==2.4.0 \
    numpy==1.24.4
    
# Set up a work directory
WORKDIR /ProteinMPNN

# Default command to run bash
CMD ["bash"]