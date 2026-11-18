# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Launcher for the XDG default terminal emulator"
HOMEPAGE="https://github.com/Vladimir-csp/xdg-terminal-exec"
SRC_URI="https://github.com/Vladimir-csp/xdg-terminal-exec/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/bx
	app-core/findutils
	app-core/gawk
"
BDEPEND="app-tex/scdoc"

src_test() {
	/bin/sh "${FILESDIR}/strict-selection.sh" "${S}/xdg-terminal-exec" "${T}/selection" || die
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
}
