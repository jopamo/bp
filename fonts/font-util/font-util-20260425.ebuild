# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X.Org font utilities"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=5c92c11482e017fa7210a71b6f44e40042816209
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
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-mapdir=${EPREFIX}/usr/share/fonts/util
		--with-fontrootdir=${EPREFIX}/usr/share/fonts
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
