# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="https://github.com/MediaArea/ZenLib"
EGIT_REPO_URI="https://github.com/MediaArea/ZenLib.git"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

DEPEND="dev-util/pkgconfig"

S=${WORKDIR}/${P}/Project/GNU/Library

src_prepare() {
	default
	sed -i 's:-O2::' configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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
	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc
}
