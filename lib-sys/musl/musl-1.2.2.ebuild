# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="an implementation of the standard library for Linux-based systems"
HOMEPAGE="http://www.musl-libc.org/"
SRC_URI="http://www.musl-libc.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemwide"

BDEPEND="sys-devel/gcc
		sys-devel/make"

DEPEND="!systemwide? ( sys-kernel/sabotage-headers )"

filter-flags -D_FORTIFY_SOURCE\=\* -Wl,-z,combreloc -Wl,-z,relro -Wl,-z,defs -Wl,-z,now -fstack-protector-strong -fstack-clash-protection

src_prepare() {
	strip-flags

	default

	cp "${FILESDIR}"/* "${S}"/
}

src_configure() {
	local systemwide=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--prefix="${EPREFIX}"/usr
    	--exec-prefix="${EPREFIX}"/usr
    	--enable-wrapper=all
	)

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/musl/lib
		--libexecdir="${EPREFIX}"/usr/musl/libexec
		--sysconfdir="${EPREFIX}/usr/musl/etc"
		--localstatedir="${EPREFIX}/usr/musl/var"
		--prefix="${EPREFIX}"/usr/musl
    	--exec-prefix="${EPREFIX}"/usr/musl
    	--enable-wrapper=all
	)

	use systemwide || ECONF_SOURCE=${S} econf "${myconf[@]}"
	use systemwide && ECONF_SOURCE=${S} econf "${systemwide[@]}"
}

src_compile() {
	local i
	for i in getconf getent iconv ; do
		gcc $CPPFLAGS $CFLAGS "${S}"/$i.c -o $i
	done

	default
}

src_install() {
	default

	if use systemwide ; then
  		for i in getconf getent iconv ; do
			dobin $i
		done

		cp -p "${ED}"/lib/ld-musl*.so* "${ED}"/usr/lib/
  		rm -rf "${ED}"/lib
	else
		cp -p "${ED}"/lib/ld-musl*.so* "${ED}"/usr/musl/lib/
  		rm -rf "${ED}"/lib
	fi
}
