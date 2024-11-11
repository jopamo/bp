# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kernel-hardening-checker"

SNAPSHOT=24c1a906d96f77202837e90d4b1f9f5d9933e1b9
SRC_URI="https://github.com/a13xp0p0v/kernel-hardening-checker/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/kernel-hardening-checker-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
