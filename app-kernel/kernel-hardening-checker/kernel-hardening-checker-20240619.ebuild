# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kernel-hardening-checker"

SNAPSHOT=d58989986070e871e1244e29019ae0cfb20a3f5b
SRC_URI="https://github.com/a13xp0p0v/kernel-hardening-checker/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"

https://github.com/a13xp0p0v/kernel-hardening-checker/archive/21cec11eb005e77917a7263a0f164a80deca0e04.zip
S="${WORKDIR}/kernel-hardening-checker-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
