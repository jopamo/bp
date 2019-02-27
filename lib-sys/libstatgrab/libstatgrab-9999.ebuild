# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A tool to provide access to statistics about the system on which it's run"
HOMEPAGE="http://www.i-scream.org/libstatgrab/"
EGIT_REPO_URI="https://github.com/i-scream/libstatgrab.git"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT=0
KEYWORDS="amd64 arm64"
IUSE="doc examples static-libs"

RDEPEND="lib-sys/ncurses"
DEPEND="${RDEPEND}"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
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
