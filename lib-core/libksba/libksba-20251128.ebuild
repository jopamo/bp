# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=2dd35bef663f5ba89260222299aabffd017c4bbd
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="X.509 and CMS (PKCS#7) library"
HOMEPAGE="http://www.gnupg.org/related_software/libksba"
SRC_URI="https://github.com/gpg/libksba/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libksba-${SNAPSHOT}

LICENSE="LGPL-3+ GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/libgpg-error"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
