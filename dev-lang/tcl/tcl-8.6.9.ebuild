# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}-core${PV}-src.tar.gz"

LICENSE="tcltk"
SLOT="0/1"
KEYWORDS="amd64 arm64"

S="${WORKDIR}/tcl${PV}/unix"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-64bit
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
