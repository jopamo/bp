# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=d4e067d96c5e868e5208613f37dfacaab4298d7c

inherit autotools dot-a

DESCRIPTION="New GNU Portable Threads Library"
HOMEPAGE="https://github.com/gpg/npth"
SRC_URI="https://github.com/gpg/npth/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/npth-${SNAPSHOT}

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	use static-libs && lto-guarantee-fat

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
	use static-libs && strip-lto-bytecode
}
