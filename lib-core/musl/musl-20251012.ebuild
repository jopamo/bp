# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=1b76ff0767d01df72f692806ee5adee13c67ef88

inherit flag-o-matic

DESCRIPTION="an implementation of the standard library for Linux-based systems"
HOMEPAGE="http://www.musl-libc.org/"

SRC_URI="https://github.com/1g4-mirror/musl/archive/${SNAPSHOT}.tar.gz -> musl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/musl-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libxcrypt elibc_musl"

src_prepare() {
	default
	cp "${FILESDIR}"/* "${S}"/ || die
}

src_configure() {
	filter-flags -flto*

	local systemwide=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
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
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/musl/lib
		--libexecdir="${EPREFIX}"/usr/musl/libexec
		--sysconfdir="${EPREFIX}/usr/musl/etc"
		--localstatedir="${EPREFIX}/usr/musl/var"
		--prefix="${EPREFIX}"/usr/musl
		--exec-prefix="${EPREFIX}"/usr/musl
		--enable-wrapper=all
		--enable-shared
		--enable-static
	)

	use elibc_musl || ECONF_SOURCE=${S} econf "${myconf[@]}"
	use elibc_musl && ECONF_SOURCE=${S} econf "${systemwide[@]}"
}

src_compile() {
	if use elibc_musl ; then
		local i
		for i in getconf getent iconv ; do
			cc $CPPFLAGS $CFLAGS "${S}"/$i.c -o $i || die
		done
	fi

	default
}

src_install() {
	default

	dodir /usr/lib
	local ldso=

	if use elibc_musl ; then
		local i
  		for i in getconf getent iconv ; do
			dobin $i
		done

		if use amd64; then
			ldso=ld-musl-x86_64.so.1
		elif use arm64; then
			ldso=ld-musl-aarch64.so.1
		fi
		[[ -n ${ldso} ]] || die "unsupported arch for musl loader symlink"
		dosym -r /usr/lib/${ldso} /usr/bin/ldd

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

	cp -p "${ED}"/lib/ld-musl*.so* "${ED}"/usr/lib/ || die
	rm -r "${ED}"/lib || die

	if use elibc_musl && [[ ! -e "${ED}"/usr/lib/libc.so ]]; then
		dosym -r /usr/lib/${ldso} /usr/lib/libc.so
	fi
}
