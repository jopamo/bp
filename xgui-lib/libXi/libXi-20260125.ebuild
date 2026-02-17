# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org Xi library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=3103b5849d89335fd57b08b91ad634216ed96073
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXi/-/archive/${SNAPSHOT}/libXi-${SNAPSHOT}.tar.bz2 -> libXi-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxi-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"

KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXfixes-5.0.1
	xgui-tools/xorgproto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	use static-libs && lto-guarantee-fat

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
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
