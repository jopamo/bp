# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs systemd

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="https://xfs.wiki.kernel.org/"
SRC_URI="https://www.kernel.org/pub/linux/utils/fs/xfs/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="icu libedit nls"

LIB_DEPEND=">=sys-app/util-linux-2.17.2[static-libs(+)]
	icu? ( lib-dev/icu:=[static-libs(+)] )
	libedit? ( lib-dev/libedit[static-libs(+)] )"
DEPEND="${LIB_DEPEND//\[static-libs(+)]}"
BDEPEND="
	nls? ( sys-devel/gettext )
"

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
	# include/builddefs.in will add FCFLAGS to CFLAGS which will
	# unnecessarily clutter CFLAGS (and fortran isn't used)
	unset FCFLAGS

	export DEBUG=-DNDEBUG

	# Package is honoring CFLAGS; No need to use OPTIMIZER anymore.
	# However, we have to provide an empty value to avoid default
	# flags.
	export OPTIMIZER=" "

	unset PLATFORM # if set in user env, this breaks configure

	# Avoid automagic on libdevmapper, #709694
	export ac_cv_search_dm_task_create=no

	local myconf=(
		--enable-blkid
		--with-crond-dir="${EPREFIX}/etc/cron.d"
		--with-systemd-unit-dir="$(systemd_get_systemunitdir)"
		$(use_enable icu libicu)
		$(use_enable nls gettext)
		$(use_enable libedit editline)
	)

	if is-flagq -flto ; then
		myconf+=( --enable-lto )
	else
		myconf+=( --disable-lto )
	fi

	econf "${myconf[@]}"
}

src_compile() {
	emake V=1
}

src_install() {
	emake DIST_ROOT="${ED}" install
	emake DIST_ROOT="${ED}" install-dev

	mkdir -p "${ED}"/usr/lib
	cp -rp "${ED}"/lib64/* "${ED}"/usr/lib/
  	rm -rf "${ED}"/lib64
}
