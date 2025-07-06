# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="https://pagure.io/libaio"
SNAPSHOT=b8eadc9f89e8f7ab0338eacda9f98a6caea76883
SRC_URI="https://github.com/1g4-mirror/libaio/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"


LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_prepare() {
	filter-flags -flto*

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
	ABI_LIBDIR=lib \
	CFLAGS_WERROR= \
	emake "$@"
}

src_compile() {
	_emake
}

src_test() {
	mkdir -p testdir || die
	# 'make check' breaks with sandbox, 'make partcheck' works
	_emake partcheck prefix="${S}/src" libdir="${S}/src"
}

src_install() {
	_emake install DESTDIR="${D}"
	export QA_DT_NEEDED=$(find "${ED}" -type f -name 'libaio.so.*' -printf '/%P\n')
}
