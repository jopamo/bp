# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson dot-a

DESCRIPTION="A standalone library to implement GNU libc's obstack and others"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
SNAPSHOT=67a50c023cf139347f3163950a9332af792dffd4
SRC_URI="https://github.com/jopamo/musl-bsd/archive/${SNAPSHOT}.tar.gz -> musl-bsd-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/musl-bsd-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="!lib-core/glibc"

src_configure() {
	use static-libs && lto-guarantee-fat

	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	use static-libs && strip-lto-bytecode
}
