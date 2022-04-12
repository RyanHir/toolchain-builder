#! /usr/bin/env bash
# shellcheck disable=SC2155

source "$(dirname "$0")/utils/funcs.sh"

if [ "${FUNC_ONLY}" = "true" ]; then
    return 0
fi

# If these fail, then others are bad aswell
env_exists V_BIN
env_exists V_GDB
env_exists V_GCC
env_exists WPI_HOST_PREFIX
env_exists DOWNLOAD_DIR


if [ "$WPI_BUILD_TUPLE" ]; then
    BUILD_TUPLE="$WPI_BUILD_TUPLE"
else
    BUILD_TUPLE="$(gcc -dumpmachine)"
fi
HOST_TUPLE="${WPI_HOST_TUPLE}"
SYSROOT_PATH="${WPI_HOST_PREFIX}/${TARGET_TUPLE}/sysroot"
SYSROOT_BUILD_PATH="$BUILD_DIR/sysroot-install/${TARGET_TUPLE}/sysroot"

CONFIGURE_COMMON_LITE=(
    "--build=${BUILD_TUPLE}"
    "--host=${HOST_TUPLE}"
    "--prefix=${WPI_HOST_PREFIX}"
    "--program-prefix=${TARGET_PREFIX}"
    "--disable-lto"
    "--disable-nls"
    "--disable-plugin"
    "--disable-werror"
    "--disable-dependency-tracking"
)

CONFIGURE_COMMON=(
    "${CONFIGURE_COMMON_LITE[@]}"
    "--target=${TARGET_TUPLE}"
    "--libexecdir=${WPI_HOST_PREFIX}/${TARGET_TUPLE}/libexec"
    "--with-sysroot=${SYSROOT_PATH}"
    "--libdir=${SYSROOT_PATH}/usr/lib"
    "--with-toolexeclibdir=${SYSROOT_PATH}/usr/lib"
    "--with-build-sysroot=${SYSROOT_BUILD_PATH}"
)

export PATH="/opt/frc/bin:${PATH}"
export CONFIGURE_COMMON_LITE CONFIGURE_COMMON
if [ "${WPI_HOST_CANADIAN}" = "true" ]; then
    # Manually tell autoconf what tools to use as the build, host, and target
    # compilers may be intended for different systems even though they have
    # the same prefix due to the tuple matching.
    configure_host_vars
    configure_target_vars
fi
