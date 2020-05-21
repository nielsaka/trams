#!/bin/bash
##################################################################
# Please note that you need to adapt this script to your job
# Submitting it as is will fail. 
##################################################################
# Define the job name
#SBATCH --job-name=TRAMS
#
# Advised: your Email here, for job notification
#SBATCH --mail-user=nielsaka@outlook.com
#SBATCH --mail-type=ALL
#     (ALL = BEGIN, END, FAIL, REQUEUE)
#
# Set a pattern for the output file.
#SBATCH --output=TRAMS-%N-%j.out
#  By default both standard output and  standard  error are 
# directed to a file of the name "slurm-%j.out", where the "%j" 
# is replaced with the job allocation number.   The filename 
# pattern may contain one or more replacement symbols, which are 
# a percent sign "%" followed by a letter (e.g. %j).
#
# Supported replacement symbols are:
#     %j     Job allocation number.
#     %N     Main node name.  
#
##################################################################
# The requested run-time
#
#SBATCH --time=25
# Acceptable time formats include "minutes", "minutes:seconds", 
# "hours:minutes:seconds", "days-hours", "days-hours:minutes" 
# and "days-hours:minutes:seconds"
#
# Slurm will kill your job after the requested period.
# The default time limit is the partition’s time limit.
#
# Note that the lower the requested run-time, the higher the
# chances to get scheduled to 'fill in the gaps' between other
# jobs. 
#
# Set quality of service (if required by server). Will affect
# job priority as well.
#
#SBATCH --qos=hiprio
#
# Options include (at FU Berlin server)
#      Name   Priority     MaxWall MaxJobs MaxSubmit     MaxTRESPU 
#---------- ---------- ----------- ------- --------- ------------- 
#    hiprio     100000    03:00:00      50       100       cpu=160 
#      prio       1000  3-00:00:00     500      1000       cpu=800 
#  standard          0 14-00:00:00    3000     10000      cpu=1600 
##################################################################
# Requested number of cores. Choose either of, or both of
#
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#
# Set a (ntasks) to be the number of process you want to launch and
# b (cpus-per-task) the number of threads per process. Typically, 
# for an MPI job with 8 processes, set a=8, b=1. For an OpenMP job
# with 12 threads, set a=1, b=12. For a hybrid 8-process, 12-threads
# per process MPI job with OpenMP 'inside', set a=8, b=12.
#
# Request number of nodes for parallel processing. E.g. for 
# symmetric multiprocessing, just request one node.
#
##SBATCH --nodes=1
#
# You can also set 
##SBATCH --ntasks-per-node=c
##SBATCH --exclusive
# to force your jobs to run at most at c at a time on a single 
# node. The --exclusive option reservers the whole node for your
# job. Remove one '#' before them to activate. 
#
##################################################################
# Requested memory for each core
#
#SBATCH --mem-per-cpu=4096 
#
# Set the memory requirements for the job in MB. Your job will be
# allocated exclusive access to that amount of RAM. In the case it
# overuses that amount, Slurm will kill it. The default value is 
# around 2GB per core.
#
# Note that the lower the requested memory, the higher the
# chances to get scheduled to 'fill in the gaps' between other
# jobs. 
#
##################################################################
# Specific features and resources
#
##SBATCH --constraint="feature1&feature2" 
#
#  Constraint the job to nodes which have feature1 and feature 2. 
#  --constraint=L5520 will direct the job to nodes with Intel Xeon
#  L5520 processors, provided the cluster configuration offers it.
#
##SBATCH --gres="resource:2"
#
#  Make sure that 2 ''resources'' are available on the node before
#  allocating a job to the node. For example, --gres=gpu:2 will 
#  reserve 2 gpu's on the node for the job, provided that the cluster
#  configuration offers it. 
#
#  Remove one '#' before them to activate.
#
#         See manpage for sbatch for other options.
#
##############
# Launch job #
##############
#
# Note that the environment variables that were set when you
# submitted your job are copied and transmitted to the computing 
# nodes. It nevertheless is good practice to reset them 
# explicitly in the script.
#
# It is also good practice to use the environment variables such
# as $HOME, $TMP, etc rather than explicit paths to ensure smooth
# portability of the script. 
#
# Select the setup you need and discard the rest.
# 
### Simple sequential job
# If you have a simple non-parallel job, just launch it. 
# Here, we'll use our singularity container called 'trams.sif'
# as our computing environment.

module add Singularity
singularity exec trams.sif make paper

# ./myprog.exe
 
### Parallel job without communications 
# The following line will launch the number of processes that was 
# requested with the --ntasks option on the nodes that were allocated
# by Slurm.

# srun -n $SLURM_NTASKS myprog.exe
# srun myprog.exe
 
### OpenMP job
# Set the number of treads equal to those requested with the 
# --cpus-per-task option.
 
# export OMP_NUM_THREADS=b
# ./myprog.exe
 
### MPI job
# The MPI implementations are aware of the Slurm environment. The
# following line will launch the number of processes that was 
# requested with the --ntasks option on the nodes that were allocated
# by Slurm. 
 
# module load openmpi
# mpirun myprog
 
### Hybrid MPI/OpenMP job
# Mix the above. Note that due to an unsolved misunderstanding between
# Slurm and OpenMPI, the SLURM_CPUS_PER_TASK environment variable must
# be unset. 
 
# export OMP_NUM_THREADS=b
# unset SLURM_CPUS_PER_TASK
# mpirun myprog.exe
 
##############
# end of job #
##############


