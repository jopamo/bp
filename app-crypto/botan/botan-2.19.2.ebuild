# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1 toolchain-funcs

DESCRIPTION="C++ crypto library"
HOMEPAGE="https://botan.randombit.net/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/randombit/botan"
	EGIT_BRANCH="release-2"
else
	MY_P="Botan-${PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://botan.randombit.net/releases/${MY_P}.tar.xz"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+boost bzip2 +lzma python ssl static-libs sqlite zlib"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	boost? ( lib-dev/boost )
	bzip2? ( app-compression/bzip2 )
	lzma? ( app-compression/xz-utils )
	python? ( ${PYTHON_DEPS} )
	ssl? ( virtual/ssl )
	sqlite? ( lib-core/sqlite )
	zlib? ( lib-core/zlib )
"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

src_configure() {
	python_setup

	local disable_modules=(
		$(usev !boost 'boost')
	)

	if [[ -z "${DISABLE_MODULES}" ]] ; then
		elog "Disabling module(s): ${disable_modules[@]}"
	fi

	local chostarch="${CHOST%%-*}"

	local pythonvers=()
	if use python ; then
		_append() {
			pythonvers+=( ${EPYTHON/python/} )
		}

		python_foreach_impl _append
	fi

	local myargs=(
		--prefix="${EPREFIX}/usr"
		--docdir=share/doc
		--libdir=lib
		$(use_enable static-libs static-library)
		$(use_with boost)
		$(use_with bzip2)
		$(use_with lzma)
		$(use_with sqlite sqlite3)
		$(use_with ssl openssl)
		$(use_with zlib)
		--cpu=${chostarch}
		--disable-modules=$( IFS=","; echo "${disable_modules[*]}" )
		--no-install-python-module
		--os=linux
		--with-endian="$(tc-endian)"
		--with-os-feature=getrandom
		--with-python-version=$( IFS=","; echo "${pythonvers[*]}" )
		--without-documentation
		--without-doxygen
		--without-sphinx
	)

	tc-export CC CXX AR

	${EPYTHON} configure.py "${myargs[@]}" || die "configure.py failed with ${EPYTHON}"
}

src_test() {
	LD_LIBRARY_PATH="${S}" ./botan-test || die "Validation tests failed"
}

src_install() {
	default

	if use python ; then
		python_foreach_impl python_domodule src/python/botan2.py
	fi
}
