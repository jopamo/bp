# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="uncompile an rgb color-name database"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=f5e3a3bb394d926842f208185dbc06c5cc2ca111
SRC_URI="https://gitlab.freedesktop.org/xorg/app/rgb/-/archive/${SNAPSHOT}/rgb-${SNAPSHOT}.tar.bz2 -> rgb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/rgb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-tools/util-macros
	xgui-tools/xorgproto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
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
