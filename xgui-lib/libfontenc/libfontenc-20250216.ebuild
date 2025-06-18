# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org fontenc library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=dcdbcce903ee49200040c0da092b45253c20c6df
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libfontenc/-/archive/${SNAPSHOT}/libfontenc-${SNAPSHOT}.tar.bz2 -> libfontenc-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libfontenc-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="lib-core/zlib
	xgui-tools/xorgproto"

DEPEND="${RDEPEND}
		fonts/font-util"

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
		--with-encodingsdir="${EPREFIX}/usr/share/fonts/encodings"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
