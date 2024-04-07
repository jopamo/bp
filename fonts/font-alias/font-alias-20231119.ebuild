# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org font aliases"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=184c43dd059f785537c8a48a4a7972c488ac1215
SRC_URI="https://gitlab.freedesktop.org/xorg/font/alias/-/archive/${SNAPSHOT}/alias-${SNAPSHOT}.tar.bz2 -> alias-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/alias-${SNAPSHOT}"

SLOT=0
KEYWORDS="amd64 arm64"

DEPEND="fonts/font-util"

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
		--with-fontrootdir=${EPREFIX}/usr/share/fonts
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
