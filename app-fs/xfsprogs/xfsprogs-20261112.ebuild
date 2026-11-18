# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="https://xfs.wiki.kernel.org/"
SNAPSHOT=e02d0a8efd81d454481641c9bd5680b5febb1261
SRC_URI="https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/snapshot/xfsprogs-dev-${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xfsprogs-dev-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libedit systemd"

DEPEND="
	lib-misc/inih
	lib-net/userspace-rcu
	app-core/util-linux
	libedit? ( lib-core/libedit )
"
BDEPEND="
	app-build/autoconf
	app-build/automake
	app-build/libtool
	app-dev/patchelf
	app-dev/pkgconf
"

src_prepare() {
	default

	# Fix doc dir
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in || die

	# Don't install compressed docs
	sed 's@\(CHANGES\)\.gz[[:space:]]@\1 @' -i doc/Makefile || die

	emake configure
}

src_configure() {
	local QA_POLICY_LTO_FLAVOR=full
	qa-policy-configure

	unset FCFLAGS
	export DEBUG=-DNDEBUG
	export OPTIMIZER=""
	unset PLATFORM
	export ac_cv_search_dm_task_create=no

	local myconf=(
		--sbindir="${EPREFIX}/usr/bin"
		--libdir="${EPREFIX}/usr/lib"
		--disable-lib64
		# qa-policy supplies LTO flags and tools; upstream requires GCC wrappers.
		--disable-lto
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
	emake DIST_ROOT="${ED}" install
	emake DIST_ROOT="${ED}" install-dev

	patchelf --remove-rpath "${ED}"/usr/bin/xfs_{io,scrub,fsr}

	cleanup_install

	qa-policy-install
}
