# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}-core${PV}-src.tar.gz"
S="${WORKDIR}/tcl${PV}/unix"

LICENSE="tcltk"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

append-flags -lm
append-ldflags -Wl,-soname,libtcl.so.1

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

	mv "${ED}"/usr/lib/libtcl$(ver_cut 1-2).so "${ED}"/usr/lib/libtcl.so.${PV}

	for x in libtcl.so.1 libtcl.so.1.0 libtcl.so ; do
		dosym libtcl.so.${PV} usr/lib/${x}
	done

	use static-libs || find "${ED}" -name '*.a' -delete
}
