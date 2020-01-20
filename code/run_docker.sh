#!/bin/sh

IMAGE="trams"
REMOTE_IMAGE="trams"

# pull or build image if not available
if docker images | grep --quiet $IMAGE ; then
	echo "$IMAGE image exists"
else
	echo "$IMAGE image DOES NOT exist"
	echo "pulling image from dockerhub"
	docker pull nielsaka/"$REMOTE_IMAGE"
	docker tag nielsaka/"$REMOTE_IMAGE" "$IMAGE"
	if docker images | grep --quiet "$IMAGE" ; then
		echo "$IMAGE container successfully created"
	else
		echo "failed to pull container"
		echo "building from Dockerfile"
		docker build -t "$IMAGE" .
		if ! docker images | grep --quiet "$IMAGE" ; then
			echo "failed to pull or build container"
			exit 1
		fi
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
	$IMAGE \
	make	

