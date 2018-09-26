# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X Window System initializer"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xorg/app/xinit.git"

LICENSE="${LICENSE} GPL-2"
KEYWORDS="amd64 arm64 x86"
SLOT=0

RDEPEND="
	!<x11-app/xorg-server-1.8.0
	x11/xauth
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
PDEPEND="x11/xrdb"

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
