# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="X.Org font aliases"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/font/alias.git"
SLOT=0
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	x11-misc/mkfontscale
	>=fonts/font-util-1.1.1-r1"

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
		--with-fontrootdir=${EPREFIX}/usr/share/fonts
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
