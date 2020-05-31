# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=5cdf0b5b0f1994405c8689ceaee76126755dcd1c

inherit autotools

DESCRIPTION="X.509 and CMS (PKCS#7) library"
HOMEPAGE="http://www.gnupg.org/related_software/libksba"
SRC_URI="https://github.com/gpg/libksba/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-3+ GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=lib-dev/libgpg-error-1.8"

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
