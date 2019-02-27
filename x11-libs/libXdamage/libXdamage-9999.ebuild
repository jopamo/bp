# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

DESCRIPTION="X.Org Xdamage library"
KEYWORDS="amd64 arm64"
SLOT=0

DEPEND=">=x11-libs/libX11-1.6.2
	>=x11-libs/libXfixes-5.0.1
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
