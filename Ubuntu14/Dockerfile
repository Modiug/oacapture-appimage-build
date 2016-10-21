FROM ubuntu:14.04
 
# Install dev tools: git etc...
RUN apt-get update
RUN apt-get install -y git wget

# Development Environment
RUN apt-get install -y build-essential pkg-config yasm autoconf libtool

RUN mkdir -p /usr/local/src

COPY build_1_oacapture.sh /usr/local/src
COPY build_2_appimagekit.sh /usr/local/src
COPY build_3_oaCaptureAppImage.sh /usr/local/src

WORKDIR /usr/local/src

CMD ["bash"]
