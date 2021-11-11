# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs git-r3 autotools

DESCRIPTION="X.Org X11 library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 test doc static-libs"

RDEPEND="xgui-live-lib/libxcb
	xgui-live-lib/xtrans
	xgui-live-app/xorgproto"
DEPEND="${RDEPEND}
	test? ( app-lang/perl )"

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
		$(use_with doc xmlto)
		$(use_enable doc specs)
		$(use_enable ipv6)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
	rm -f "${ED}"/usr/include/X11/extensions/XKBgeom.h
}
