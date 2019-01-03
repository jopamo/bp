# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils user versionator flag-o-matic

DESCRIPTION="a man replacement that utilizes gdbm instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="+manpager nls selinux static-libs zlib"

CDEPEND=">=lib-dev/libpipeline-1.4.0
	lib-sys/gdbm
	sys-app/groff
	zlib? ( lib-sys/zlib )
	!sys-app/man"
DEPEND="${CDEPEND}
	app-compression/xz-utils
	dev-util/pkgconfig
	nls? (
		>=app-text/po4a-0.45
		sys-devel/gettext
	)"
RDEPEND="${CDEPEND}"
PDEPEND="manpager? ( sys-app/less )"

pkg_setup() {
	# Create user now as Makefile in src_install does setuid/chown
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_configure() {
	filter-flags -flto
	export ac_cv_lib_z_gzopen=$(usex zlib)
	local myeconfargs=(
		--docdir='$(datarootdir)'/doc/${PF}
		--with-systemdtmpfilesdir="${EPREFIX}"/usr/lib/tmpfiles.d
		--enable-setuid
		--enable-cache-owner=man
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p o 1x 2x 3x 4x 5x 6x 7x 8x"
		$(use_enable nls)
		$(use_enable static-libs static)
		--with-db=gdbm
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name "*.la" -delete || die
}
