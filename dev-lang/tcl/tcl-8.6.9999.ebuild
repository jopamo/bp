# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"
EGIT_REPO_URI="https://github.com/tcltk/tcl.git"
EGIT_BRANCH="core-$(ver_cut 1)-$(ver_cut 2)-branch"
S="${WORKDIR}/${P}/unix"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="dev-util/patchelf"

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

	for x in libtcl$(ver_cut 1-2).so.1 libtcl.so libtcl.so.$(ver_cut 1-2).0 ; do
		dosym libtcl$(ver_cut 1-2).so usr/lib/${x}
	done

	patchelf --set-soname libtcl.so.$(ver_cut 1-2).0 "${ED}"/usr/lib/libtcl8.6.so
}
