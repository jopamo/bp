# Distributed under the terms of the GNU General Public License v2

inherit distutils-r1

DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kernel-hardening-checker"
SNAPSHOT=e354f6ab5279f9cfa8bfdd7e13e454ccf69209f9
SRC_URI="https://github.com/a13xp0p0v/kernel-hardening-checker/archive/${SNAPSHOT}.tar.gz -> kernel-hardening-checker-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/kernel-hardening-checker-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
