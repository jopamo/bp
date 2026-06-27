# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org X authorization library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=14ba0f63c4ba2229dd17574134332767bded9018
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXau/-/archive/${SNAPSHOT}/libXau-${SNAPSHOT}.tar.bz2 -> libXau-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxau-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xgui-tools/xorgproto
	xgui-tools/util-macros"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	qa-policy-configure
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
