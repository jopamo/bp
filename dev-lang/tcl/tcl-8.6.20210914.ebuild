# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tcltk/tcl.git"
	EGIT_BRANCH="core-$(ver_cut 1)-$(ver_cut 2)-branch"
	S="${WORKDIR}/${P}/unix"
	inherit git-r3
else
	SNAPSHOT=92e2e6942a579c17849b0cf13cafb557a7e0678d
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
