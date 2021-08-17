# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user flag-o-matic

DESCRIPTION="a man replacement that utilizes gdbm instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+manpager nls static-libs systemd tmpfilesd zlib"

DEPEND="
	>=lib-core/libpipeline-1.4.0
	lib-core/gdbm
	app-core/groff
	zlib? ( lib-core/zlib )
	app-compression/xz-utils
	dev-util/pkgconf
	nls? (
		>=app-text/po4a-0.45
		sys-devel/gettext
	)"

PDEPEND="manpager? ( app-core/less )"

filter-flags -Wl,-z,defs

pkg_setup() {
	# Create user now as Makefile in src_install does setuid/chown
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
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
		$(use_enable nls)
		$(use_enable static-libs static)
		--with-db=gdbm
	)
	econf "${myconf[@]}"
}
