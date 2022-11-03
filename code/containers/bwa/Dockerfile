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
 && apt-get clean

WORKDIR /opt/bin
COPY --from=build /opt/src/bwa .

ENV PATH=/opt/bin:$PATH

WORKDIR /scratch

ENTRYPOINT ["bwa"]