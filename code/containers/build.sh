#!/bin/bash
set -e

# Get the current AWS id
AWS_ACCOUNT=`aws sts get-caller-identity | grep 'Account' | grep -P -o '\d{12}'`

# Set a default namespace to register the container with ECR
DEFAULT_PROJECT_NAME="biotech"


IMAGE_NAME=$1
AWS_REGION=$2
PROJECT_NAME="${3:-$DEFAULT_PROJECT_NAME}"
DOCKER_FILE_PATH="./${IMAGE_NAME}/Dockerfile"
REGISTRY="$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com"
REPOSITORY_NAME="${PROJECT_NAME}/${IMAGE_NAME}"
IMAGE_TAG=":latest"
IMAGE_WITH_TAG="${IMAGE_NAME}${IMAGE_TAG}"
REGISTRY_PATH="${REGISTRY}/${REPOSITORY_NAME}"
REGISTRY_PATH_WITH_TAG="${REGISTRY}/${PROJECT_NAME}/${IMAGE_WITH_TAG}"


if [[ -z "${IMAGE_NAME}" ]]; then
    echo "Missing image name parameter."
    exit 1
fi

if [[ ! -f "${DOCKER_FILE_PATH}" ]]; then
    echo "${DOCKER_FILE_PATH} does not exist on the filesystem."
    exit 1
fi

if [[ -z $AWS_REGION ]]; then
    echo "Missing AWS Region parameter."
    exit 1
fi


LOGIN_RESULT=`eval $(aws ecr get-login-password --region ${AWS_REGION})`

if [[ ! $LOGIN_RESULT = "Succeeded" ]]; then
    echo "Login to ECR using region ${AWS_REGION} failed, check"
    #exit 1
else
    echo "Login to ECR successful"
fi


# Check if the repository exists in ECR and if not, create it
REPO=`aws ecr describe-repositories | grep -o ${REGISTRY_PATH}` || true
if [  "${REPO}" != "${REGISTRY_PATH}" ]
then
    aws ecr create-repository --repository-name ${REPOSITORY_NAME}
fi

# build the base image
docker build \
    -t ${IMAGE_NAME} \
    -f ${DOCKER_FILE_PATH} .

# build the image with an AWS specific entrypoint
docker build \
    --build-arg BASE_IMAGE=${IMAGE_NAME} \
    -t ${IMAGE_WITH_TAG} \
    -f ./entry.dockerfile .
    

# tag the image
docker tag ${IMAGE_WITH_TAG} ${REGISTRY_PATH}


# push the image to the registry
docker push ${REGISTRY_PATH_WITH_TAG}