# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Stand-alone build of libbpf from the Linux kernel"
HOMEPAGE="https://github.com/libbpf/libbpf"
SNAPSHOT=fc687b8ee934b7331fa6561311346ce8cf8086fa
SRC_URI="https://github.com/libbpf/libbpf/archive/${SNAPSHOT}.tar.gz -> libbpf-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libbpf-${SNAPSHOT}/src

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

PATCHES=(
	"${FILESDIR}"/libbpf-9999-paths.patch
)

src_configure() {
	append-cflags -fPIC
	tc-export CC AR PKG_CONFIG
	export LIBSUBDIR="lib"
	export PREFIX="${EPREFIX}/usr"
	export V=1
}

src_install() {
	emake \
		DESTDIR="${D}" \
		LIBSUBDIR="${LIBSUBDIR}" \
		install install_uapi_headers

	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
	fi

	insinto /usr/lib/pkgconfig
	doins libbpf.pc
}
