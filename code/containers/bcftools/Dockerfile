FROM public.ecr.aws/lts/ubuntu:22.04 AS build

ARG VERSION=1.16

# Metadata
LABEL container.base.image="public.ecr.aws/lts/ubuntu:22.04"
LABEL software.name="BCFtools"
LABEL software.version=${VERSION}
LABEL software.description="Utilities for variant calling and manipulating files in the Variant Call Format (VCF) and its binary counterpart BCF"
LABEL software.website="http://www.htslib.org"
LABEL software.documentation="http://www.htslib.org/doc/bcftools.html"
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
RUN wget -O /bcftools-${VERSION}.tar.bz2 \
  https://github.com/samtools/bcftools/releases/download/${VERSION}/bcftools-${VERSION}.tar.bz2

RUN tar xvjf /bcftools-${VERSION}.tar.bz2 
RUN rm /bcftools-${VERSION}.tar.bz2

WORKDIR /bcftools-${VERSION}
RUN ./configure && make

FROM public.ecr.aws/lts/ubuntu:22.04 AS final
COPY --from=build /bcftools-*/bcftools /usr/local/bin

RUN apt-get -y update && \
    apt-get -y install \
      libcurl3-gnutls && \
    apt-get clean

ENTRYPOINT ["bcftools"]