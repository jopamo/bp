# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xv library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=f315ec50fcad9bdbaed46c3e78dc5e7fe209f933
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXv/-/archive/${SNAPSHOT}/libXv-${SNAPSHOT}.tar.bz2 -> libXv-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxv-${SNAPSHOT}"

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
