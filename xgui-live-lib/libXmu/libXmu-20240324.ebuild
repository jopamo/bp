# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xmu library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=cc378e4f0cc2ab5b66d378050ba4956612a01197
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXmu/-/archive/${SNAPSHOT}/libXmu-${SNAPSHOT}.tar.bz2 -> libXmu-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxmu-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 doc static-libs"

DEPEND=">=xgui-live-lib/libXt-1.1.4
	>=xgui-live-lib/libXext-1.3.2
	>=xgui-live-lib/libX11-1.6.2
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
		$(use_enable ipv6)
		$(use_enable doc docs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
