# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A standalone library to implement GNU libc's obstack."
HOMEPAGE="https://github.com/void-linux/musl-obstack"

SNAPSHOT=d0493f4726835a08c5a145bce42b61a65847c6a9
SRC_URI="https://github.com/void-linux/musl-obstack/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="!lib-core/glibc"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
