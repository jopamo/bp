# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gentoo's multi-purpose configuration and management tool"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Eselect"
SRC_URI="https://dev.gentoo.org/~ulm/eselect/${P}.tar.xz"

LICENSE="GPL-2+ || ( GPL-2+ CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/sed
	app-core/file
	virtual/curses
"

src_install() {
	default

	rm -rf "${ED}"/usr/share/man || die
}
