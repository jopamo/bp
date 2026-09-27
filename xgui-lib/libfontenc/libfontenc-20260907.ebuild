# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org fontenc library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=8f2a514b06584f3efd303fcb99e9fb25f75d0906
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
	qa-policy-configure
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
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
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
