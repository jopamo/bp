# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Gentoo's multi-purpose configuration and management tool"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Eselect"
SRC_URI="https://dev.gentoo.org/~ulm/eselect/${P}.tar.xz"

LICENSE="GPL-2+ || ( GPL-2+ CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="vim-syntax"

RDEPEND="sys-app/sed
	|| (
		sys-app/coreutils
		sys-freebsd/freebsd-bin
		app-misc/realpath
	)"
DEPEND="${RDEPEND}"

RDEPEND="${RDEPEND}
	sys-app/file
	lib-sys/ncurses:0"

PDEPEND="vim-syntax? ( app-text/eselect-syntax )"

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
