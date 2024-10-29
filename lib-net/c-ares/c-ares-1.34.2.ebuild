# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="https://c-ares.haxx.se/"

SRC_URI="https://github.com/c-ares/c-ares/releases/download/v${PV}/${P}.tar.gz"

#SNAPSHOT=809d5e84f3423ab8165650d923acb0e246cbd006
#SRC_URI="https://github.com/c-ares/c-ares/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
#S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--enable-symbol-hiding
		--disable-tests
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
