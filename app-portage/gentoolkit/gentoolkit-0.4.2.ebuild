# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=(python3_7)
PYTHON_REQ_USE="xml(+),threads(+)"

inherit distutils-r1

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SRC_URI="https://dev.gentoo.org/~mgorny/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="sys-app/portage[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	!app-portage/gentoolkit-dev
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
	# Create cache directory for revdep-rebuild
	mkdir -p -m 0755 "${EROOT%/}"/var/cache
	mkdir -p -m 0700 "${EROOT%/}"/var/cache/revdep-rebuild

	einfo "Starting with version 0.4.0, ebump, ekeyword and imlate are now"
	einfo "part of the gentoolkit package."
	einfo "The gentoolkit-dev package is now deprecated in favor of a single"
	einfo "gentoolkit package.   The remaining tools from gentoolkit-dev"
	einfo "are now obsolete/unused with the git based tree."

	# Only show the elog information on a new install
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog
		elog "For further information on gentoolkit, please read the gentoolkit"
		elog "guide: https://wiki.gentoo.org/wiki/Gentoolkit"
		elog
		elog "Another alternative to equery is app-portage/portage-utils"
		elog
		elog "Additional tools that may be of interest:"
		elog
		elog "    sys-app/eclean-kernel"
		elog "    app-portage/diffmask"
		elog "    app-portage/flaggie"
		elog "    app-portage/install-mask"
		elog "    app-portage/portpeek"
		elog "    app-portage/smart-live-rebuild"
	fi
}
