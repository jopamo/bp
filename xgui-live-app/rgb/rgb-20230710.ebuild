# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="uncompile an rgb color-name database"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=0d2caecebf0e2a10994c22960921f366dd98d19a
SRC_URI="https://gitlab.freedesktop.org/xorg/app/rgb/-/archive/${SNAPSHOT}/rgb-${SNAPSHOT}.tar.bz2 -> rgb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/rgb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-app/util-macros
	xgui-live-app/xorgproto"

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
