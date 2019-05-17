# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X Window System initializer"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="
	!<x11-app/xorg-server-1.8.0
	x11-app/xauth
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
PDEPEND="x11-app/xrdb"

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
