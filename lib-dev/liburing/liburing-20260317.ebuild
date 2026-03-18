# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs qa-policy

DESCRIPTION="Userspace library for efficient Linux io_uring support"
HOMEPAGE="https://github.com/axboe/liburing"
SNAPSHOT=1e9a937e10e892595ad09faeec3e5ee79646135e
SRC_URI="https://github.com/axboe/liburing/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1 MIT"
SLOT="0/2"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	qa-policy-configure
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

	qa-policy-install
}
