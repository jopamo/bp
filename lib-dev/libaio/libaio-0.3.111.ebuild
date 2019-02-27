# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://lse.sourceforge.net/io/aio.html"
SRC_URI="mirror://debian/pool/main/liba/${PN}/${PN}_${PV}.orig.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs test"

PATCHES=(
	"${FILESDIR}"/${PN}-0.3.109-install.patch
	"${FILESDIR}"/${PN}-0.3.110-cppflags.patch
	"${FILESDIR}"/${PN}-0.3.110-link-stdlib.patch
)

src_prepare() {
	default
	local sed_args=(
		-e "/^prefix=/s:/usr:${EPREFIX}/usr:"
		-e '/^libdir=/s:lib$:$(ABI_LIBDIR):'
	)
	if ! use static-libs; then
		sed_args+=( -e '/\tinstall .*\/libaio.a/d' )
		# Tests require the static library to be built.
		use test || sed_args+=( -e '/^all_targets +=/s/ libaio.a//' )
	fi
	sed -i "${sed_args[@]}" src/Makefile Makefile || die
}

_emake() {
	CC=$(tc-getCC) \
	AR=$(tc-getAR) \
	RANLIB=$(tc-getRANLIB) \
	ABI_LIBDIR=lib64 \
	CFLAGS_WERROR= \
	emake "$@"
}

src_compile() {
	filter-flags -flto
	_emake
}

src_test() {
	mkdir -p testdir || die
	# 'make check' breaks with sandbox, 'make partcheck' works
	_emake partcheck prefix="${S}/src" libdir="${S}/src"
}

src_install() {
	_emake install DESTDIR="${D}"
}

src_install_all() {
	export QA_DT_NEEDED=$(find "${ED}" -type f -name 'libaio.so.*' -printf '/%P\n')
}
