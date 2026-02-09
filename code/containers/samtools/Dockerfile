FROM public.ecr.aws/lts/ubuntu:22.04 AS build

ARG VERSION=1.16.1

# Metadata
LABEL container.base.image="public.ecr.aws/lts/ubuntu:22.04"
LABEL software.name="SAMtools"
LABEL software.version=${VERSION}
LABEL software.description="Utilities for the Sequence Alignment/Map (SAM/BAM/CRAM) formats"
LABEL software.website="http://www.htslib.org"
LABEL software.documentation="http://www.htslib.org/doc/samtools.html"
LABEL software.license="MIT/Expat"
LABEL tags="Genomics"

# System and library dependencies
RUN apt-get -y update && \
    apt-get -y install \
      autoconf \
      automake \
      make \
      gcc \
      perl \
      zlib1g-dev \
      libbz2-dev \
      liblzma-dev \
      libcurl4-gnutls-dev \
      libssl-dev \
      libncurses5-dev \
      bzip2 \
      wget && \
    apt-get clean

# Application installation
RUN wget -O /samtools-${VERSION}.tar.bz2 \
  https://github.com/samtools/samtools/releases/download/${VERSION}/samtools-${VERSION}.tar.bz2 

RUN tar xvjf /samtools-${VERSION}.tar.bz2
RUN rm /samtools-${VERSION}.tar.bz2

WORKDIR /samtools-${VERSION}
RUN ./configure && make

FROM public.ecr.aws/lts/ubuntu:22.04 AS final
COPY --from=build /samtools-*/samtools /usr/local/bin

RUN apt-get -y update && \
    apt-get -y install \
      libcurl3-gnutls \
      curl \
      unzip && \
    apt-get clean

# Install AWS CLI v2
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# Verify installation
RUN aws --version

# Copy entrypoint script
COPY entrypoint.sh /opt/bin/entrypoint.sh
RUN chmod +x /opt/bin/entrypoint.sh

ENTRYPOINT ["/opt/bin/entrypoint.sh"]