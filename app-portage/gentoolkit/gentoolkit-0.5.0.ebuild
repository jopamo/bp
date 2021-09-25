# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SRC_URI="https://gitweb.gentoo.org/proj/gentoolkit.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="tmpfilesd"

DEPEND="app-core/portage[${PYTHON_USEDEP}]
		app-core/gentoo-functions"

python_prepare_all() {
	python_setup
	echo VERSION="${PVR}" "${PYTHON}" setup.py set_version
	VERSION="${PVR}" "${PYTHON}" setup.py set_version
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	use tmpfilesd || rm -rf "${ED}"/usr/lib/tmpfiles.d
}

pkg_postinst() {
	mkdir -p -m 0755 "${EROOT}"/var/cache
	mkdir -p -m 0700 "${EROOT}"/var/cache/revdep-rebuild
}
