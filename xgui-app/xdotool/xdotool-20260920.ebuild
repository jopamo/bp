# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Simulate keyboard input and mouse activity, move and resize windows"
HOMEPAGE="https://www.semicomplete.com/projects/xdotool/"
SNAPSHOT=14ca26a2c95035f9c635a6a11d075e8d7d0d6529
SRC_URI="https://github.com/jordansissel/xdotool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libXinerama
	xgui-lib/libXtst
	xgui-lib/libxkbcommon
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/pkgconf
	app-lang/perl
"

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
