# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org X authorization library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a9c65683e68b3a4349afee5d7673b393fb924d2e
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
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
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