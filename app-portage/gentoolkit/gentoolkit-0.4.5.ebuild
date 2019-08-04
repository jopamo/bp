# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SRC_URI="https://gitweb.gentoo.org/proj/gentoolkit.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="sys-app/portage[${PYTHON_USEDEP}]
		sys-app/gentoo-functions"

python_prepare_all() {
	python_setup
	echo VERSION="${PVR}" "${PYTHON}" setup.py set_version
	VERSION="${PVR}" "${PYTHON}" setup.py set_version
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	mkdir -p -m 0755 "${EROOT}"/var/cache
	mkdir -p -m 0700 "${EROOT}"/var/cache/revdep-rebuild
}
