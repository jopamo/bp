# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org XScrnSaver library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=723953c9a8dba44bcb1866cf06a54be74fbb8089
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXScrnSaver/-/archive/${SNAPSHOT}/libXScrnSaver-${SNAPSHOT}.tar.bz2 -> libXScrnSaver-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxscrnsaver-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	xgui-tools/xorgproto"

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
