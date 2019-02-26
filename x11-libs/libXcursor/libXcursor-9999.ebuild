# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="X.Org Xcursor library"
KEYWORDS="amd64 arm64"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git
SLOT=0

RDEPEND=">=x11-libs/libXrender-0.9.8[${MULTILIB_USEDEP}]
	>=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}]
	>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-icondir=/usr/share/cursors/xorg-x11
		--with-cursorpath='~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps'
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
