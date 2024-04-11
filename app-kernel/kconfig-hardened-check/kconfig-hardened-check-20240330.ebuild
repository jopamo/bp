# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kconfig-hardened-check"

SNAPSHOT=74963559e760568c1d4b11e4c120e792efd428e4
SRC_URI="https://github.com/a13xp0p0v/kconfig-hardened-check/archive/${SNAPSHOT}.tar.gz -> kconfig-hardened-check-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/kernel-hardening-checker-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
