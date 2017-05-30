##
# Lustre test suite configuration 
#
# MPI is setup to use eth0 currently
##

# Enables verbose acc-sm output.
VERBOSE=${VERBOSE:-"false"}
#VERBOSE=true

# File system configuration
FSNAME="lustre"
FSTYPE=ldiskfs

# Network configuration
NETTYPE="tcp"

# fact hosts
mds_HOST=${mds_HOST:-triage-worker-0}
mgs_HOST=${mgs_HOST:-$mds_HOST}
ost_HOST=${ost_HOST:-triage-worker-1}

# MDS and MDT configuration
MDSCOUNT=1
SINGLEMDS=${SINGLEMDS:-mds1}

MDSSIZE=4194304
MDS_FS_MKFS_OPTS=${MDS_FS_MKFS_OPTS:-}
MDS_MOUNT_OPTS=${MDS_MOUNT_OPTS:-}
MDSFSTYPE=ldiskfs

mds1_HOST="triage-worker-0"
MDSDEV1="/dev/vdb"
mds1_MOUNT="/mnt/lustre/mdt0"
mds1_FSTYPE=ldiskfs

# MGS and MGT configuration
mgs_HOST=${mgs_HOST:-"$mds_HOST"} # combination mgs/mds
MGSOPT=${MGSOPT:-}
MGS_FS_MKFS_OPTS=${MGS_FS_MKFS_OPTS:-}
MGS_MOUNT_OPTS=${MGS_MOUNT_OPTS:-}
MGSFSTYPE=ldiskfs

MGSDEV="/dev/vdc"
MDSSIZE=4194304
MGSNID="10.10.10.174@tcp"
mgs_FSTYPE=ldiskfs

# OSS and OST configuration
OSTCOUNT=${OSTCOUNT:-4}
OSTSIZE=${OSTSIZE:-33554432}
OSTFSTYPE=ldiskfs

ost1_HOST="triage-worker-1"
OSTDEV1="/dev/vdb"
ost1_MOUNT="/mnt/lustre/ost1"
ost1_FSTYPE=ldiskfs

ost2_HOST="triage-worker-1"
OSTDEV2="/dev/vdc"
ost2_MOUNT="/mnt/lustre/ost2"
ost2_FSTYPE=ldiskfs

ost3_HOST="triage-worker-2"
OSTDEV3="/dev/vdb"
ost3_MOUNT="/mnt/lustre/ost3"
ost3_FSTYPE=ldiskfs

ost4_HOST="triage-worker-2"
OSTDEV4="/dev/vdc"
ost4_MOUNT="/mnt/lustre/ost4"
ost4_FSTYPE=ldiskfs

# OST striping configuration
STRIPE_BYTES=${STRIPE_BYTES:-1048576}
STRIPES_PER_OBJ=${STRIPES_PER_OBJ:-0}

# Client configuration
CLIENTCOUNT=2
#CLIENTS="triage-master.novalocal, feature-build"
CLIENTS=""
CLIENT1="triage-master.novalocal"
CLIENT2="feature-build"
RCLIENTS="feature-build"

MOUNT="/mnt/lustre"
MOUNT1="/mnt/lustre"
MOUNT2="/mnt/lustre2"
DIR=${DIR:-$MOUNT}
DIR1=${DIR:-$MOUNT1}
DIR2=${DIR2:-$MOUNT2}

# UID and GID configuration
# Used by several tests to set the UID and GID
if [ $UID -ne 0 ]; then
        log "running as non-root uid $UID"
        RUNAS_ID="$UID"
        RUNAS_GID=`id -g $USER`
        RUNAS=""
else
        RUNAS_ID=${RUNAS_ID:-500}
        RUNAS_GID=${RUNAS_GID:-$RUNAS_ID}
        RUNAS=${RUNAS:-"runas -u $RUNAS_ID -g $RUNAS_GID"}
fi

# Software configuration
PDSH="/usr/bin/pdsh -S -Rssh -w"
FAILURE_MODE=${FAILURE_MODE:-SOFT} # or HARD
POWER_DOWN=${POWER_DOWN:-"powerman --off"}
POWER_UP=${POWER_UP:-"powerman --on"}
SLOW=${SLOW:-no}
FAIL_ON_ERROR=${FAIL_ON_ERROR:-true}

cbench_DIR=/usr/bin
cnt_DIR=/opt/connectathon

PIOSBIN=/usr/bin/pios

# Debug configuration
#PTLDEBUG=${PTLDEBUG:-"vfstrace rpctrace dlmtrace neterror ha config \
PTLDEBUG=${PTLDEBUG:-"vfstrace dlmtrace neterror ha config \
		      ioctl super lfsck"}
SUBSYSTEM=${SUBSYSTEM:-"all -lnet -lnd -pinger"}

# Lustre timeout
TIMEOUT=${TIMEOUT:-"30"}

# promise 2MB for every cpu
if [ -f /sys/devices/system/cpu/possible ]; then
    _debug_mb=$((($(cut -d "-" -f 2 /sys/devices/system/cpu/possible)+1)*2))
else
    _debug_mb=$(($(getconf _NPROCESSORS_CONF)*2))
fi

DEBUG_SIZE=${DEBUG_SIZE:-$_debug_mb}
DEBUGFS=${DEBUGFS:-"/sbin/debugfs"}

#TMP=${TMP:-/tmp}
SHARED_DIRECTORY="/mnt/archive/shared"

# Set-up shell environment for openmpi
[ -r /etc/profile.d/openmpi.sh ] && . /etc/profile.d/openmpi.sh
MPIRUN=/usr/lib64/compat-openmpi16/bin/mpirun
MPIRUN_OPTIONS="-mca boot ssh"
[ "${NETTYPE}" = tcp ] &&
    MPIRUN_OPTIONS="--mca btl tcp,self --mca btl_tcp_if_include eth0 --mca boot ssh"

AGTCOUNT=1
AGTDEV1="/mnt/hsm"
agt1_HOST="feature-build"
HSMTOOL_VERBOSE="-v -v -v -v -v -v"

. /usr/lib64/lustre/tests/cfg/ncli.sh
