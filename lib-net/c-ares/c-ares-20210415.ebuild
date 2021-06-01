# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

SNAPSHOT=809d5e84f3423ab8165650d923acb0e246cbd006

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="https://c-ares.haxx.se/"
SRC_URI="https://github.com/c-ares/c-ares/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	eapply "${FILESDIR}"/${PN}-1.12.0-remove-tests.patch

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-nonblocking
		--enable-symbol-hiding
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
