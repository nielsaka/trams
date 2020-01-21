#!/bin/sh

REPO="nielsaka"
IMAGE="trams"
REMOTE_IMAGE="trams"

BUILD=$1

exists_docker () {
	docker images | grep --quiet "$IMAGE"
}	

pull_docker () {
	echo "pulling image from dockerhub"
	docker pull $REPO/"$REMOTE_IMAGE"
	docker tag $REPO/"$REMOTE_IMAGE" "$IMAGE"
	if exists_docker; then
		echo "$IMAGE image successfully pulled"
	else
		echo "failed to pull image"
	fi
}

build_docker () {
	echo "building from Dockerfile"
	docker build -t "$IMAGE" .
	if exists_docker; then
		echo "$IMAGE image successfully built"
	else
		echo "failed to build image"
	fi
}

if [ "$BUILD" = "local" ]; then
	build_docker
fi

if ! exists_docker; then
	echo "$IMAGE does not exist"
	pull_docker;
	if ! exists_docker; then
		build_docker
	fi
fi

# ----------
# make paper
# ----------

docker run \
	--rm \
	-i	\
	-v $(pwd):/home/$IMAGE \
	-w /home/$IMAGE \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	$IMAGE \
	make paper	

