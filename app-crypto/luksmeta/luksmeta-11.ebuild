# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="Library and CLI for storing metadata in LUKS1 headers"
HOMEPAGE="https://github.com/latchset/luksmeta"
SRC_URI="https://github.com/latchset/luksmeta/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-fs/cryptsetup"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/pkgconf"

src_configure() {
	qa-policy-configure
	econf --disable-static
}

src_install() {
	default
	qa-policy-install
}
