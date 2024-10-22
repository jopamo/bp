# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a portable, high level programming interface to various calling conventions"
HOMEPAGE="https://github.com/libffi/libffi"

SNAPSHOT=8308bed5b2423878aa20d7884a99cf2e30b8daf7
SRC_URI="https://github.com/libffi/libffi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
