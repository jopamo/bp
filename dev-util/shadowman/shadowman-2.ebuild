# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unified compiler shadow link directory updater"
HOMEPAGE="https://github.com/mgorny/shadowman"
SRC_URI="https://github.com/mgorny/shadowman/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-misc/eselect"
DEPEND="${RDEPEND}"

src_install() {
	# tool modules are split into their respective packages
	emake DESTDIR="${D}" prefix="${EPREFIX}"/usr install \
		INSTALL_MODULES_TOOL=""
	keepdir /usr/share/shadowman/tools
}
