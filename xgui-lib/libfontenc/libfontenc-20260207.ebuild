# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org fontenc library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=780d1f6f192a331de7b298a96e23ebc44d2a884b
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
	use static-libs && lto-guarantee-fat

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
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
