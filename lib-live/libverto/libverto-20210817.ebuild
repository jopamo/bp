# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="an async event loop abstraction library"
HOMEPAGE="https://github.com/latchset/libverto"

SNAPSHOT=0dc4e8f1fc9184a2b45cb00e3c7aebcb9a1d53d3
SRC_URI="https://github.com/latchset/libverto/archive/${SNAPSHOT}.tar.gz -> libverto-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libverto-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
