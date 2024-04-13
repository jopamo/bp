# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="https://github.com/MediaArea/ZenLib"

SNAPSHOT=26b4aa1853d9b893ce5dd655571dc2673f47aa8e
SRC_URI="https://github.com/MediaArea/ZenLib/archive/${SNAPSHOT}.tar.gz -> ZenLib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ZenLib-${SNAPSHOT}/Project/GNU/Library"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

DEPEND="app-dev/pkgconf"

src_prepare() {
	default
	sed -i 's:-O2::' configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-unicode
		--enable-shared
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	insinto /usr/lib/pkgconfig
	doins ${PN}.pc
}
