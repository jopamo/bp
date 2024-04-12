# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="tcltk/tcl - Tool Command Language"
HOMEPAGE="http://www.tcl.tk/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tcltk/tcl.git"
	EGIT_BRANCH="core-$(ver_cut 1)-$(ver_cut 2)-branch"
	S="${WORKDIR}/${P}/unix"
	inherit git-r3
else
	SNAPSHOT=12cf9a5e58c41c6b5edcf26083cb3028b8f7715f
	SRC_URI="https://github.com/tcltk/tcl/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}/unix
fi

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-dev/patchelf"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	ECONF_SOURCE=${S} econf --enable-64bit
}

src_install() {
	default

	for x in libtcl$(ver_cut 1-2).so.1 libtcl.so libtcl.so.$(ver_cut 1-2).0 ; do
		dosym libtcl$(ver_cut 1-2).so usr/lib/${x}
	done

	patchelf --set-soname libtcl.so.$(ver_cut 1-2).0 "${ED}"/usr/lib/libtcl8.6.so
}
