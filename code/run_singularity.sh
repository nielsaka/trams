
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

# bind current working dir to $HOME; 
# otherwise reproducibility is much diminished!
# will access R packages and binaries...

singularity exec --bind $PWD:$HOME "$IMAGE" make paper

