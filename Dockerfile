FROM ubuntu:16.04
MAINTAINER masa1023 "west013minami@gmail.com"

# Install necessary tools
RUN apt-get update && apt-get install -y \
    apt-utils \
    git \
    sudo \
    vim \
    lsb-release \
    curl \
    wget \
    lsb-release \
    libmysqlclient-dev

# Add user
ARG user_name="ubuntu"
ARG user_password="password"
RUN useradd -m ${user_name} && \
    echo "${user_name}:${user_password}" | chpasswd
RUN echo "${user_name} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${user_name}

# Install python and relevant tools
RUN sudo apt-get install -y \
    build-essential \
    python3 \
    python \
    python-dev \
    libxml2-dev \
    libxslt-dev \
    libssl-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev \
    python-pip

# Upgrade version of pip
RUN sudo pip install --upgrade pip

# Set environment variables
ENV CLOUD_SDK_REPO "cloud-sdk-xenial"
ENV PYTHONPATH /usr/lib/google-cloud-sdk/platform/google_appengine

# Install Google Cloud SDK libraries
RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN sudo apt-get update && sudo apt-get install -y google-cloud-sdk
RUN sudo apt-get install -y \
    google-cloud-sdk-app-engine-python \
    google-cloud-sdk-app-engine-python \
    google-cloud-sdk-app-engine-python-extras \
    google-cloud-sdk-datastore-emulator

