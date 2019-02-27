# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="X.Org xkbcommon library"
HOMEPAGE="https://xkbcommon.org/"
KEYWORDS="amd64 arm64"
IUSE="X doc test"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/xkbcommon/libxkbcommon.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://xkbcommon.org/download/${P}.tar.xz"
fi

SLOT=0

DEPEND="sys-devel/bison
	X? ( x11/xorgproto )
	doc? ( app-text/doxygen )"
RDEPEND="X? ( >=x11-libs/libxcb-1.10[xkb] )"

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
		--with-xkb-config-root="${EPREFIX}/usr/share/X11/xkb"
		$(use X || use_enable X x11)
		$(use_with doc doxygen)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
