# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X.Org xset application"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git
SLOT=0

KEYWORDS="amd64 arm64 x86"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext"
DEPEND="${RDEPEND}"

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
		--without-xf86misc
		--without-fontcache
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
