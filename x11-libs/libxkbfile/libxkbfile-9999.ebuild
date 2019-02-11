# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal autotools

DESCRIPTION="X.Org xkbfile library"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/freedesktop/xorg-${PN}/archive/${P}.tar.gz"
	S="${WORKDIR}/xorg-${PN}-${P}"
fi

SLOT=0

KEYWORDS="amd64 arm64"

DEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
