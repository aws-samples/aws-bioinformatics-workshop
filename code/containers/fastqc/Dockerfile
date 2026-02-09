# base image
FROM public.ecr.aws/lts/ubuntu:22.04

# metadata
LABEL base.image="ubuntu:22.04"
LABEL version="1"
LABEL software="FASTQC"
LABEL software.version="0.11.9"
LABEL description="A quality control analysis tool for high throughput sequencing data"
LABEL website="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/"
LABEL license="https://github.com/s-andrews/FastQC/blob/master/LICENSE.txt"
LABEL maintainer="Abigail Shockey"
LABEL maintainer.email="abigail.shockey@slh.wisc.edu"

RUN apt-get update && apt-get install -y \
  default-jre \
  libcommons-math3-java \
  libfindbin-libs-perl \
  libhtsjdk-java \
  libjbzip2-java \
  libsis-jhdf5-java \
  fastqc \
  curl \
  unzip \
  && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

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

RUN mkdir /data
WORKDIR /data

ENTRYPOINT ["/opt/bin/entrypoint.sh"]