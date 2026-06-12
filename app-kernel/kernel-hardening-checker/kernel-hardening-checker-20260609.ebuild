# Distributed under the terms of the GNU General Public License v2

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end
DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kernel-hardening-checker"
SNAPSHOT=0b9aebf818145f772407135b79418958c1ec5ed1
SRC_URI="https://github.com/a13xp0p0v/kernel-hardening-checker/archive/${SNAPSHOT}.tar.gz -> kernel-hardening-checker-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/kernel-hardening-checker-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
