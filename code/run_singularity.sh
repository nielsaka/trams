
IMAGE="trams.sif"
REPO="nielsaka"
REMOTE_IMAGE="trams"

####################
# Create Container #
####################

if ! [ -f "$IMAGE" ]; then
	singularity pull $IMAGE docker://"$REPO"/"$REMOTE_IMAGE"
fi 

##############
# Make Paper #
##############

# differentiate between remaking complete paper (including big simulation)
# or building from intermediate results?

singularity exec "$IMAGE" make paper

