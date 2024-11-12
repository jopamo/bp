# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Stand-alone build of libbpf from the Linux kernel"
HOMEPAGE="https://github.com/libbpf/libbpf"

if [[ ${PV} =~ [9]{4,} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/libbpf/libbpf.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha amd64 ~arm arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
fi
S="${WORKDIR}/${P}/src"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
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
	doins ${PN}.pc
}
