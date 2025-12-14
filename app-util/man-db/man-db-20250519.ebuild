# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit doins

DESCRIPTION="a man replacement that utilizes gdbm instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"

SNAPSHOT=2b38f74972ab09985b0f7a6716a08c657ff716d8
SRC_URI="https://gitlab.com/man-db/man-db/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs systemd zlib"

DEPEND="
	lib-core/libpipeline
	lib-core/libseccomp
	lib-core/gdbm
	app-core/groff
	zlib? ( lib-core/zlib )
"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	rm -rf gnulib
	cp -r "${BROOT}"/usr/share/gnulib gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	./bootstrap || die

	default
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	export ac_cv_lib_z_gzopen=$(usex zlib)

	local myconf=(
		--docdir='$(datarootdir)'/doc/${PF}
		--with-systemdtmpfilesdir="${EPREFIX}"/usr/lib/tmpfiles.d
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--disable-setuid
		--enable-cache-owner=man
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p"
		--disable-nls
		$(use_enable static-libs static)
		--with-db=gdbm
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	newsysusers "${FILESDIR}/${PN}-sysusers" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
}
