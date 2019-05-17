# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org Xi library"
KEYWORDS="amd64 arm64"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=x11-libs/libX11-1.6.2
	>=x11-libs/libXext-1.3.2
	>=x11-libs/libXfixes-5.0.1
	x11-misc/xorgproto"

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
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
