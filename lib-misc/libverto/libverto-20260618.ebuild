# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="an async event loop abstraction library"
HOMEPAGE="https://github.com/latchset/libverto"

SNAPSHOT=8e944f22dcce2aa1f37c517e7881dd49d4d631ee
SRC_URI="https://github.com/latchset/libverto/archive/${SNAPSHOT}.tar.gz -> libverto-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libverto-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
