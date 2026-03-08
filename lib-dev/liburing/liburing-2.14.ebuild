# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs dot-a

DESCRIPTION="Userspace library for efficient Linux io_uring support"
HOMEPAGE="https://github.com/axboe/liburing"
SNAPSHOT=e3d35ea59d3ba09075ed4d7751e4bb9049cce64a
SRC_URI="https://github.com/axboe/liburing/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1 MIT"
SLOT="0/2"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
}

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--includedir="${EPREFIX}"/usr/include
		--libdir="${EPREFIX}"/usr/lib
		--libdevdir="${EPREFIX}"/usr/lib
		--mandir="${EPREFIX}"/usr/share/man
		--datadir="${EPREFIX}"/usr/share
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
	)

	./configure "${myconf[@]}" || die
}

src_compile() {
	emake library liburing.pc liburing-ffi.pc
}

src_install() {
	emake DESTDIR="${ED}" install

	if ! use static-libs; then
		rm -f "${ED}"/usr/lib/liburing.a \
			"${ED}"/usr/lib/liburing-ffi.a || die
	fi

	use static-libs && strip-lto-bytecode
}
