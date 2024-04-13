# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="https://xfs.wiki.kernel.org/"
SRC_URI="https://www.kernel.org/pub/linux/utils/fs/xfs/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libedit systemd"

DEPEND="
	lib-misc/inih
	app-core/util-linux
	libedit? ( lib-core/libedit )
"
BDEPEND="app-dev/patchelf"

src_prepare() {
	default

	# Fix doc dir
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in || die

	# Don't install compressed docs
	sed 's@\(CHANGES\)\.gz[[:space:]]@\1 @' -i doc/Makefile || die
}

src_configure() {
	unset FCFLAGS
	export DEBUG=-DNDEBUG
	export OPTIMIZER=""
	unset PLATFORM
	export ac_cv_search_dm_task_create=no

	local myconf=(
		--enable-blkid
		--enable-lto
		--with-crond-dir="${EPREFIX}/etc/cron.d"
		--with-systemd-unit-dir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--disable-libicu
		--disable-gettext
		$(use_enable libedit editline)
	)

	econf "${myconf[@]}"
}

src_compile() {
	emake V=1
}

src_install() {
	emake DIST_ROOT="${ED}" PKG_ROOT_SBIN_DIR=/usr/sbin install
	emake DIST_ROOT="${ED}" PKG_ROOT_SBIN_DIR=/usr/sbin install-dev

	patchelf --remove-rpath "${ED}"/usr/sbin/xfs_{io,scrub,fsr}

	cp -rp "${ED}"/lib/* "${ED}"/usr/lib/ || die
	rm -rf "${ED}"/lib || die

	cleanup_install
}
