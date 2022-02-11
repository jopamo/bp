# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 flag-o-matic

DESCRIPTION="A modern linker"
HOMEPAGE="https://github.com/rui314/mold"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-AFFERO"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -flto\*

src_prepare() {
	sed -i '/O2/d' Makefile
	sed -i '/STRIP/d' Makefile
	default
}

src_compile() {
	emake CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		LIBDIR="${ED}"/usr/lib
}

src_install() {
	emake PREFIX="${ED}"/usr install
}
