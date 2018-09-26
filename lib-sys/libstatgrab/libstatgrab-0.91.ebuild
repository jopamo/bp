# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A tool to provide access to statistics about the system on which it's run"
HOMEPAGE="http://www.i-scream.org/libstatgrab/"
SRC_URI="http://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/libstatgrab/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT=0
KEYWORDS="amd64 arm64 x86"
IUSE="doc examples static-libs"

RDEPEND="lib-sys/ncurses"
DEPEND="${RDEPEND}"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-setgid-binaries
		--disable-setuid-binaries
		--with-ncurses
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
