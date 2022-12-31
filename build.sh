# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BootleggersROM/manifest.git -b queso -g default,-mips,-darwin,-notdefault
git clone https://github.com/ifeincarnation/local_manifest --depth 1 -b bootleg-10 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

source build/envsetup.sh
export BUILD_USERNAME=$BUILD_USERNAME
export BUILD_HOSTNAME=$BUILD_HOSTNAME
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
lunch bootleg_whyred-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
mka bacon -j8  > reading & sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
