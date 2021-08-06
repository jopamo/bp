# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tcltk/tcl.git"
	EGIT_BRANCH="core-$(ver_cut 1)-$(ver_cut 2)-branch"
	S="${WORKDIR}/${P}/unix"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=0a3d4c25af0dab62fc3dd608c96316ec9b8afca2
	SRC_URI="https://github.com/tcltk/tcl/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}/unix
	KEYWORDS="amd64 arm64"
fi

LICENSE="tcltk"
SLOT="0"

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
