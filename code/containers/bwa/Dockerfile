FROM public.ecr.aws/lts/ubuntu:22.04 AS build

ARG BWA_VERSION=0.7.17

RUN apt-get update -y \
 && apt-get install -y \
    git \
    make \
    gcc \
    zlib1g-dev \
    bzip2


WORKDIR /opt/src
RUN git clone https://github.com/lh3/bwa.git \
 && cd bwa \
 && make


FROM public.ecr.aws/lts/ubuntu:22.04 AS final

RUN apt-get update -y \
 && apt-get install -y \
    zlib1g \
    bzip2 \
    curl \
    unzip \
 && apt-get clean

# Install AWS CLI v2
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# Verify installation
RUN aws --version

WORKDIR /opt/bin
COPY --from=build /opt/src/bwa .

# Copy entrypoint script
COPY entrypoint.sh /opt/bin/entrypoint.sh
RUN chmod +x /opt/bin/entrypoint.sh

ENV PATH=/opt/bin:$PATH

WORKDIR /scratch

ENTRYPOINT ["/opt/bin/entrypoint.sh"]