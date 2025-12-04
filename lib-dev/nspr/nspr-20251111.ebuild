# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="Netscape Portable Runtime"
HOMEPAGE="http://www.mozilla.org/projects/nspr/"
SNAPSHOT=0ea5e81e77a9f849b4652916d89170cd6dffd82f
SRC_URI="https://salsa.debian.org/mozilla-team/nspr/-/archive/${SNAPSHOT}/debianutils-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( MPL-2.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug"

src_prepare() {
	cd "${S}"/nspr || die

	default

	# rename configure.in to configure.ac for new autotools compatibility
	if [[ -e "${S}"/nspr/configure.in ]] ; then
		einfo "Renaming configure.in to configure.ac"
		mv "${S}"/nspr/configure.{in,ac} || die
	fi

	# We must run eautoconf to regenerate configure
	eautoconf

	# make sure it won't find Perl out of Prefix
	sed -i -e "s/perl5//g" "${S}"/nspr/configure || die

	# Respect LDFLAGS
	sed -i -e 's/\$(MKSHLIB) \$(OBJS)/\$(MKSHLIB) \$(LDFLAGS) \$(OBJS)/g' \
		"${S}"/nspr/config/rules.mk || die
}

src_configure() {
	# We use the standard BUILD_xxx but nspr uses HOST_xxx
	tc-export_build_env BUILD_CC
	export HOST_CC=${BUILD_CC} HOST_CFLAGS=${BUILD_CFLAGS} HOST_LDFLAGS=${BUILD_LDFLAGS}
	tc-export AR CC CXX RANLIB
	[[ ${CBUILD} != ${CHOST} ]] \
		&& export CROSS_COMPILE=1 \
		|| unset CROSS_COMPILE

	local myconf=(
		--libdir="${EPREFIX}/usr/lib"
		$(use_enable debug)
		$(use_enable !debug optimize)
		--enable-64bit
	)

	# Ancient autoconf needs help finding the right tools.
	LC_ALL="C" ECONF_SOURCE="${S}/nspr" \
	ac_cv_path_AR="${AR}" \
	econf "${myconf[@]}"
}

src_install() {
	# Their build system is royally confusing, as usual
	MINOR_VERSION=${MIN_PV} # Used for .so version
	emake DESTDIR="${D}" install

	einfo "removing static libraries as upstream has requested!"
	rm "${ED%/}"/usr/lib/*.a || die "failed to remove static libraries."

	# install nspr-config
	dobin config/nspr-config

	# Remove stupid files in /usr/bin
	rm "${ED%/}"/usr/bin/prerr.properties || die

	# This is used only to generate prerr.c and prerr.h at build time.
	# No other projects use it, and we don't want to depend on perl.
	# Talked to upstream and they agreed w/punting.
	rm "${ED%/}"/usr/bin/compile-et.pl || die
}
