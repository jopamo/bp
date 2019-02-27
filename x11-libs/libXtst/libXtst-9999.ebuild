# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

DESCRIPTION="X.Org Xlib-based client API for the XTEST & RECORD extensions library"
SLOT=0
IUSE=static-libs
KEYWORDS="amd64 arm64"

DEPEND=">=x11-libs/libX11-1.6.2
	>=x11-libs/libXext-1.3.2
	>=x11-libs/libXi-1.7.2
	x11/xorgproto"

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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
