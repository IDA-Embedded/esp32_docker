# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set the frontend to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install the ESP-IDF dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    flex \
    bison \
    gperf \
    python3 \
    python3-pip \
    python3-setuptools \
    ninja-build \
    ccache \
    libffi-dev \
    libssl-dev \
    dfu-util \
    libusb-1.0-0-dev \
    screen \
    && rm -rf /var/lib/apt/lists/*

# Install the `python3-venv` package from the `universe` repository
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Uninstall cmake
RUN apt-get remove -y cmake
# Install CMake using pip
RUN python3 -m pip install cmake

# Create a symbolic link from /usr/bin/python to /usr/bin/python3
RUN ln -s /root/.espressif/python_env/idf5.2_py3.8_env/bin/python3 /usr/bin/python
# Create a symbolic link from /usr/bin/cmake to /root/.espressif/python_env/idf5.2_py3.8_env/bin/cmake
RUN ln -s /root/.espressif/python_env/idf5.2_py3.8_env/bin/cmake /usr/bin/cmake

# Install the ESP-IDF version 5.1
RUN git clone --recursive -b release/v5.1 https://github.com/espressif/esp-idf.git /opt/esp-idf




# Set the environment variables
ENV IDF_PATH=/opt/esp-idf
ENV PATH="$PATH:$IDF_PATH/tools"
ENV PATH="$PATH:/root/.espressif/python_env/idf4.2_py3.8_env/bin"

# Export the IDF_PATH
RUN echo ". $IDF_PATH/export.sh" >> /root/.bashrc

# install esp-idf
RUN sh $IDF_PATH/install.sh

# Set the working directory
WORKDIR /app


# Copy the project files into the container
COPY . .
# Copy the entrypoint.sh script into the container
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the entrypoint.sh script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]