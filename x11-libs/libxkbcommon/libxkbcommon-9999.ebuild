# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X.Org xkbcommon library"
HOMEPAGE="https://xkbcommon.org/"
KEYWORDS="amd64 arm64 x86"
IUSE="X doc test"
EGIT_REPO_URI="https://github.com/xkbcommon/libxkbcommon.git"
SLOT=0

DEPEND="sys-devel/bison
	X? ( x11/xorgproto )
	doc? ( app-text/doxygen )"
RDEPEND="X? ( >=x11-libs/libxcb-1.10[${MULTILIB_USEDEP},xkb] )"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-xkb-config-root="${EPREFIX}/usr/share/X11/xkb"
		$(use X || use_enable X x11)
		$(use_with doc doxygen)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
