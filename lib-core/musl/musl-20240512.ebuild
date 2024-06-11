# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=007997299248b8682dcbb73595c53dfe86071c83

inherit flag-o-matic

DESCRIPTION="an implementation of the standard library for Linux-based systems"
HOMEPAGE="http://www.musl-libc.org/"
SRC_URI="https://git.musl-libc.org/cgit/musl/snapshot/musl-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
https://git.musl-libc.org/cgit/musl/snapshot/musl-007997299248b8682dcbb73595c53dfe86071c83.tar.gz
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="musl libxcrypt"

src_prepare() {
	default
	cp "${FILESDIR}"/* "${S}"/ || die
}

src_configure() {
	filter-flags -flto*

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
		--enable-shared
		--enable-static
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
		--disable-shared
		--enable-static
	)

	use musl || ECONF_SOURCE=${S} econf "${myconf[@]}"
	use musl && ECONF_SOURCE=${S} econf "${systemwide[@]}"
}

src_compile() {
	if use musl ; then
		local i
		for i in getconf getent iconv ; do
			cc $CPPFLAGS $CFLAGS "${S}"/$i.c -o $i || die
		done
	fi

	default
}

src_install() {
	default

	if use musl ; then
		local i
  		for i in getconf getent iconv ; do
			dobin $i
		done

		mkdir -p "${ED}"/usr/lib || die
		cp -p "${ED}"/lib/ld-musl*.so* "${ED}"/usr/lib/ || die
		rm -r "${ED}"/lib || die

		use amd64 && dosym -r /usr/lib/ld-musl-x86_64.so.1 /usr/bin/ldd
		use arm64 && dosym -r /usr/lib/ld-musl-aarch64.so.1 /usr/bin/ldd

		insopts -m 0644
		insinto /etc/env.d
		doins 02locale

		if use libxcrypt ; then
			rm "${ED}"/usr/include/crypt.h || die
		fi
	else
		for i in linux asm asm-generic mtd ; do
			dosym -r /usr/include/$i /usr/musl/include/$i
		done
	fi
}
