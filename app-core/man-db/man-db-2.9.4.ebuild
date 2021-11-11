# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user flag-o-matic

DESCRIPTION="a man replacement that utilizes gdbm instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs systemd sysusersd tmpfilesd zlib"

DEPEND="
	lib-core/libpipeline
	lib-core/libseccomp
	lib-core/gdbm
	app-core/groff
	zlib? ( lib-core/zlib )
"
BDEPEND="app-dev/pkgconf"

filter-flags -Wl,-z,defs

pkg_setup() {
	if ! use sysusersd; then
		enewgroup man 15
		enewuser man 13 -1 /usr/share/man man
	fi
}

src_configure() {
	export ac_cv_lib_z_gzopen=$(usex zlib)

	local myconf=(
		--docdir='$(datarootdir)'/doc/${PF}
		--with-systemdtmpfilesdir=$(usex tmpfilesd "${EPREFIX}"/usr/lib/tmpfiles.d "false")
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--enable-setuid
		--enable-cache-owner=man
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p o 1x 2x 3x 4x 5x 6x 7x 8x"
		--disable-nls
		$(use_enable static-libs static)
		--with-db=gdbm
	)
	econf "${myconf[@]}"
}
