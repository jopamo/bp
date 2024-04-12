# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A standalone library to implement GNU libc's obstack."
HOMEPAGE="https://github.com/void-linux/musl-obstack"

SNAPSHOT=362629706cb24a68b5e02876f0250df95e2e3f8d
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
