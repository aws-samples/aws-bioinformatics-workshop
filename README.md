## AWS Bioinformatics Workshop

This repository is meant to be used with the AWS Bioinformatics Workshop 
(ADD URL).

## Repo structure

```bash
.
└── code
    └── batch_jobs                          <-- A directory containing sample job files to use be submitted to AWS Batch
    └── containers                          <-- A directory containing bioinformatics containers and containers building tools
        └── bcftools/bwa/fastqc/samtools    <-- Directories containing bioinformatics Dockerfiles
        └── build.sh                        <-- A utility script to build and register containers
        └── entry.dockerfile                <-- A Dockerfile used by the build utility
        └── entrypoint.sh                   <-- A shell script to be used in the containers for staging data on S3
    └── scripts
        └── resize.sh                       <-- A volume resize utility
    └── vpc                                 <-- A directory containing a CDK app to launch a VPC
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

