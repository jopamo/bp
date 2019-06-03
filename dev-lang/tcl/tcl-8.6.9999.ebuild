# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"
EGIT_REPO_URI="https://github.com/tcltk/tcl.git"
EGIT_BRANCH="core-$(ver_cut 1)-$(ver_cut 2)-branch"
S="${WORKDIR}/${P}/unix"

LICENSE="tcltk"
SLOT="0/1"
KEYWORDS="amd64 arm64"

append-ldflags -Wl,-soname,libtcl$(ver_cut 1-2).so.1

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-64bit
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	for x in libtcl$(ver_cut 1-2).so.1 libtcl.so ; do
		dosym libtcl$(ver_cut 1-2).so usr/lib/${x}
	done
}
