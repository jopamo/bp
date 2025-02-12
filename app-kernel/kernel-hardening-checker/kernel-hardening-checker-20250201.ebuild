# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kernel-hardening-checker"

SNAPSHOT=0c00f3fa766496d221ae3b79ce3f6730468f3641
SRC_URI="https://github.com/a13xp0p0v/kernel-hardening-checker/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/kernel-hardening-checker-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
