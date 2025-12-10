# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Simulate keyboard input and mouse activity, move and resize windows"
HOMEPAGE="https://www.semicomplete.com/projects/xdotool/"

SNAPSHOT=b8e19878356fb3763c069abd42ee0911b83eb445
SRC_URI="https://github.com/jordansissel/xdotool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# tests have various troublesome requirements
RESTRICT="test"

src_prepare() {
	default

	sed -i 's/pkg-config/$(PKG_CONFIG)/' Makefile || die
}

src_compile() {
	tc-export CC LD PKG_CONFIG

	emake PREFIX="${EPREFIX}"/usr
}

src_install() {
	emake PREFIX="${ED}"/usr INSTALLMAN="${ED}"/usr/share/man \
		INSTALLLIB="${ED}"/usr/lib LDCONFIG=: install
}
