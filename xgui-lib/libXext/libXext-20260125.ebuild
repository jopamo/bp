# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xext library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=2a694ba264ccdb205909909abfe8b136f9156ebe
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXext/-/archive/${SNAPSHOT}/libXext-${SNAPSHOT}.tar.bz2 -> libXext-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxext-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2:=
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
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
