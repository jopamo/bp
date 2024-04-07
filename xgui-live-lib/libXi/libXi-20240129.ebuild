# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xi library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=57ce2e8ba4c1f1bc5792e14bc7082f3ebd0915be
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXi/-/archive/${SNAPSHOT}/libXi-${SNAPSHOT}.tar.bz2 -> libXi-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libXi-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=xgui-live-lib/libX11-1.6.2
	>=xgui-live-lib/libXext-1.3.2
	>=xgui-live-lib/libXfixes-5.0.1
	xgui-live-app/xorgproto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
