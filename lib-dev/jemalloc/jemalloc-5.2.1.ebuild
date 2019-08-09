# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://jemalloc.net/ https://github.com/jemalloc/jemalloc"
SRC_URI="https://github.com/jemalloc/jemalloc/releases/download/${PV}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug lazy-lock static-libs stats xmalloc"

PATCHES=( 	${FILESDIR}/56126d0d2d0730acde6416cf02efdb9ed19d578b.patch
			${FILESDIR}/07ce2434bf45420ff9d9d22590f68540c6dd7b78.patch
			${FILESDIR}/87e2400cbb8b5a49f910b3c72b10297fcc9df839.patch
)

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_enable debug)
		$(use_enable lazy-lock)
		$(use_enable stats)
		$(use_enable xmalloc)
		--disable-syscall
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
