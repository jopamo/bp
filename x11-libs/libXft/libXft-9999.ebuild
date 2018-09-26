# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X.Org Xft library"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git
SLOT=0

KEYWORDS="amd64 arm64 x86"

DEPEND=">=x11-libs/libXrender-0.9.8[${MULTILIB_USEDEP}]
	>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	>=lib-media/freetype-2.5.0.1[${MULTILIB_USEDEP}]
	>=lib-media/fontconfig-2.10.92[${MULTILIB_USEDEP}]
	x11/xorgproto
	fonts/liberation-fonts"

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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
