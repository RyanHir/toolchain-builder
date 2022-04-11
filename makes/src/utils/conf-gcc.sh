#! /usr/bin/env bash

function gcc_make_multi() {
    function _make() {
        make -j"$JOBS" "${@}" || return
    }
    function _make_installer() {
        make DESTDIR="${BUILD_DIR}/gcc-install" "${@}" || return
    }

    process_background "Building GCC '$1'" _make "all-$1" ||
        die "GCC build '$1'"
    process_background "Installing GCC '$1'" _make_installer "install-$1" ||
        die "GCC install '$1'"
}

CONFIGURE_GCC=(
    "${CONFIGURE_COMMON[@]}"
    "--with-cpu=${TARGET_CPU}"
    "--with-fpu=${TARGET_FPU}"
    "--with-arch=${TARGET_ARCH}"
    "--with-float=${TARGET_FLOAT}"
    "--with-specs=${TARGET_SPECS}"
    "--enable-poison-system-directories"
    "--enable-threads=posix"
    "--enable-shared"
    "--with-gcc-major-version-only"
    "--enable-linker-build-id"
    "--enable-__cxa_atexit" # Should be enabled on glibc devices
    "--with-gxx-include-dir=${SYSROOT_PATH}/usr/include/c++/${V_GCC/.*/}"
)

if [ "${WPI_HOST_NAME}" != "Windows" ]; then
    if [ "${WPI_HOST_NAME}" = "Linux" ]; then
        # Use system zlib when building target code on Linux
        CONFIGURE_GCC+=("--with-system-zlib")
    fi
    # Don't use zlib on MacOS as it is not ensured that zlib is avaliable
    CONFIGURE_GCC+=(
        "--enable-default-pie"
    )
fi

if [ "${TARGET_DISTRO}" = "roborio" ]; then
    # Pulled by running gcc -v on target device
    CONFIGURE_GCC+=(
        "--disable-libmudflap"
        "--enable-c99"
        "--enable-symvers=gnu"
        "--enable-long-long"
        "--enable-libstdcxx-pch"
        "--enable-libssp"
        "--enable-libitm"
        "--enable-initfini-array"
        "--without-long-double-128"
    )
else
    # Pulled by running gcc -v on target devices
    CONFIGURE_GCC+=(
        # Debian specific flags
        "--enable-clocal=gnu"
        "--without-included-gettext"
        "--enable-libstdcxx-debug"
        "--enable-libstdcxx-time=yes"
        "--with-default-libstdcxx-abi=new"
        "--enable-gnu-unique-object"
    )
    case "${TARGET_PORT}" in
    # Debian Port specific flags
    amd64) CONFIGURE_GCC+=(
        "--disable-vtable-verify"
        "--disable-multilib"
        "--enable-libmpx"
    ) ;;
    armhf) CONFIGURE_GCC+=(
        "--disable-libitm"
        "--disable-libquadmath"
        "--disable-libquadmath-support"
    ) ;;
    arm64) CONFIGURE_GCC+=(
        "--disable-libquadmath"
        "--disable-libquadmath-support"
    ) ;;
    esac
fi

enabled_languages="--enabled-languages=c,c++"

if [ "${TARGET_DISTRO}" = "roborio" ]; then
    enabled_languages+=",fortran"
fi
CONFIGURE_GCC+=(enabled_languages)
