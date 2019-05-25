# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="X.Org xkbfile library"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/freedesktop/xorg-${PN}/archive/${P}.tar.gz"
	S="${WORKDIR}/xorg-${PN}-${P}"
fi

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="x11-libs/libX11
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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
