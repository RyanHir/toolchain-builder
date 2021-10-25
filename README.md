# Robotics Toolchains

## Supported Languages
  * C
  * C++
  * Fortran (roboRIO only)

## Supported Hosts

| OS | Arch | Minimum Supported Release |
| - | - | - |
| Windows | i686 | Windows 7 |
| Windows | x86_64 | Windows 7 |
| Linux | armv7 | Ubuntu 16.04 |
| Linux | arm64 | Ubuntu 16.04 |
| Linux | i686 * | Ubuntu 16.04 |
| Linux | x86_64 | Ubuntu 16.04 |
| Mac | arm64 | macOS 11.0 |
| Mac | x86_64 | macOS 10.9 |
| Mac | Universal | - |

\* Linux i686 is only built for Raspbian targets

## Supported Targets

| Architecture | Operating System | Tuple |
| - | - | - |
| ARMv7 (softfp) | N.I. Linux (roboRIO) Stable | arm-frc2022-linux-gnueabi |
| ARMv7 (softfp) | N.I. Linux (roboRIO) Staging | arm-frc2022-linux-gnueabi |
| ARMv6z | Raspberry Pi OS 10 | armv6z-buster-linux-gnueabihf |
| ARMv6z | Raspberry Pi OS 11 | armv6z-bullseye-linux-gnueabihf |
| ARMv7 | Debian/Raspberry Pi OS 10 | armv7-buster-linux-gnueabihf |
| ARMv7 | Debian/Raspberry Pi OS 11 | armv7-bullseye-linux-gnueabihf |
| ARMv7 | Ubuntu 18.04 | armv7-bionic-linux-gnueabihf |
| ARMv7 | Ubuntu 20.04 | armv7-focal-linux-gnueabihf |
| ARMv8 (64bit) | Debian/Raspberry Pi OS 10 | aarch64-buster-linux-gnu |
| ARMv8 (64bit) | Debian/Raspberry Pi OS 11 | aarch64-bullseye-linux-gnu |
| ARMv8 (64bit) | Ubuntu 18.04 | aarch64-bionic-linux-gnu |
| ARMv8 (64bit) | Ubuntu 20.04 | aarch64-focal-linux-gnu |
| x86_64 | Debian 10 | x86_64-buster-linux-gnu |
| x86_64 | Debian 11 | x86_64-bullseye-linux-gnu |
| x86_64 | Ubuntu 18.04 | x86_64-bionic-linux-gnu |
| x86_64 | Ubuntu 20.04 | x86_64-focal-linux-gnu |

* Note: Debian toolchains should work with Raspberry Pi OS when ran on a Pi 2 or newer 
-----

## Resources
  * [Linaro GCC toolchains](https://releases.linaro.org/components/toolchain/binaries/)
    * Good examples of (generic) ARM toolchains
  * [GCC Build instructions and configs](https://gcc.gnu.org/install/)

## Credits
  * (majenko) [Using lipo to combine toolchains](https://majenko.co.uk/blog/how-i-cross-compile-fat-binary-cross-compiler-os-x-big-sur)
  * (crosstool-ng) [GCC patches for M1 hosting](https://github.com/crosstool-ng/crosstool-ng/)
    * Copyright is owned by original authors of the patches and the Free Software Foundation where applicable
