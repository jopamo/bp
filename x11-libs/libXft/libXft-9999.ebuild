# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="X.Org Xft library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND=">=x11-libs/libXrender-0.9.8
	>=x11-libs/libX11-1.6.2
	>=x11-libs/libXext-1.3.2
	>=lib-media/freetype-2.5.0.1
	>=lib-media/fontconfig-2.10.92
	x11-misc/xorgproto
	fonts/liberation-fonts"

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
