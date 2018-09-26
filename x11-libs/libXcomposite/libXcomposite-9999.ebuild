# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X.Org Xcomposite library"

KEYWORDS="amd64 arm64 x86"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git
SLOT=0
IUSE="doc"

DEPEND=">=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}]
	x11/xorgproto"

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
		$(use_with doc xmlto)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
