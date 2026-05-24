# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="uncompile an rgb color-name database"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=2b2019cabfe5697f54fde2f95c5d00395909458f
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
