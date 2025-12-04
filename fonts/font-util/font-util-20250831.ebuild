# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org font utilities"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=7af30077fc459e7fe3415ffa803583d7465a8a99
SRC_URI="https://gitlab.freedesktop.org/xorg/font/util/-/archive/${SNAPSHOT}/util-${SNAPSHOT}.tar.bz2 -> util-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/util-${SNAPSHOT}"

SLOT=0
KEYWORDS="amd64 arm64"

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
		--with-mapdir=${EPREFIX}/usr/share/fonts/util
		--with-fontrootdir=${EPREFIX}/usr/share/fonts
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
