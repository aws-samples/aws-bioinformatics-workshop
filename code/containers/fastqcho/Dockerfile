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
  && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*


RUN mkdir /data
WORKDIR /data

#ENTRYPOINT ["fastqc"]