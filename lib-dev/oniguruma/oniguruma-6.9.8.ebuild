# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Regular expression library for different character encodings"
HOMEPAGE="https://github.com/kkos/oniguruma"
SRC_URI="https://github.com/kkos/${PN}/releases/download/v${PV}/onig-${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0/4"
KEYWORDS="amd64 arm64"

IUSE="crnl-as-line-terminator static-libs"

S="${WORKDIR}/onig-${PV}"

src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable crnl-as-line-terminator) \
		$(use_enable static-libs static)
}
