# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="Synchronize files between a PC and an Android device using ADB"
HOMEPAGE="https://github.com/jb2170/better-adb-sync"

SNAPSHOT=2d19f23b2ae8a74e4d4e038df049112408335a6b
SRC_URI="https://github.com/jb2170/better-adb-sync/archive/${SNAPSHOT}.tar.gz -> better-adb-sync-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/better-adb-sync-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="arm64 amd64"
