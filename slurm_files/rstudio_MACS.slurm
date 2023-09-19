#!/bin/sh
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH -p long-28core
#SBATCH --output=rstudio-server.log.%j



# set the path to the directory containing the rstudio server singularity image
RSTUDIO_DIR=/gpfs/software/rstudio/server/singularity/devel/

# set the port to be used on local machine.  Customize as necessary
LOCALPORT=8003

# Create temporary directory to be populated with directories to bind-mount in the container
# where writable file systems are necessary. Adjust path as appropriate for your computing environment.
workdir=$(python -c 'import tempfile; print(tempfile.mkdtemp())')

mkdir -p -m 700 ${workdir}/run ${workdir}/tmp ${workdir}/var/lib/rstudio-server
cat > ${workdir}/database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END

# Set OMP_NUM_THREADS to prevent OpenBLAS (and any other OpenMP-enhanced
# libraries used by R) from spawning more threads than the number of processors
# allocated to the job.
#
# Set R_LIBS_USER to a path specific to rocker/rstudio to avoid conflicts with
# personal libraries from any R installation in the host environment

cat > ${workdir}/rsession.sh <<END
#!/bin/sh
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export R_LIBS_USER=${HOME}/R/rocker-rstudio/4.2
exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END

chmod +x ${workdir}/rsession.sh

export SINGULARITY_BIND="${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server,/gpfs/software/glpk/glpk-5.0/lib:/usr/local/lib/glpk,/gpfs/projects/MallipattuGroup/:/gpfs/projects/MallipattuGroup/"

# Do not suspend idle sessions.
# Alternative to setting session-timeout-minutes=0 in /etc/rstudio/rsession.conf
# https://github.com/rstudio/rstudio/blob/v1.4.1106/src/cpp/server/ServerSessionManager.cpp#L126
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT=0

export SINGULARITYENV_USER=$(id -un)
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L ${LOCALPORT}:${HOSTNAME}:${PORT} ${SINGULARITYENV_USER}@${SLURM_SUBMIT_HOST}.seawulf.stonybrook.edu

   and point your web browser to http://localhost:${LOCALPORT}

When done using RStudio Server, terminate the job by:

1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:

      scancel -f ${SLURM_JOB_ID}
END

singularity exec --cleanenv ${RSTUDIO_DIR}/rstudio_rocker_devel.sif \
/usr/lib/rstudio-server/bin/rserver --www-port ${PORT} \
--server-user ${SINGULARITYENV_USER} \
--rsession-path=/etc/rstudio/rsession.sh


