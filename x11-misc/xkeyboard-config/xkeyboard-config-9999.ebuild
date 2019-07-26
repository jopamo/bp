# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI=https://github.com/freedesktop/${PN}.git
	inherit git-r3
else
	SRC_URI="https://www.x.org/pub/individual/data/${PN}/${P}.tar.bz2"
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0/1"

RDEPEND="!<x11-misc/xkbcomp-1.2.3
	!<x11-libs/libX11-1.4.3"
DEPEND="
	sys-devel/gettext
	dev-util/intltool"

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
		--with-xkb-base="${EPREFIX}/usr/share/X11/xkb"
		--enable-compat-rules
		--disable-runtime-deps
		--with-xkb-rules-symlink=xorg
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
