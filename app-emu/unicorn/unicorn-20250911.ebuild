# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_OPTIONAL=1

inherit cmake distutils-r1 flag-o-matic

DESCRIPTION="CPU emulator framework"
HOMEPAGE="https://github.com/unicorn-engine/unicorn"
SNAPSHOT=c24c9ebe773ce6fbecb0e39f68ffb23b7326b17f
SRC_URI="https://github.com/unicorn-engine/unicorn/archive/${SNAPSHOT}.tar.gz -> unicorn-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/unicorn-${SNAPSHOT}"

LICENSE="BSD-2 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="logging python static-libs test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="${PYTHON_DEPS}"
RDEPEND="python? ( ${PYTHON_DEPS} )"
BDEPEND="
	python? (
		${DISTUTILS_DEPS}
		>=dev-py/setuptools-scm-8[${PYTHON_USEDEP}]
	)"

RESTRICT="!test? ( test )"

UNICORN_TARGETS="x86_64 aarch64"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

wrap_python() {
	if use python; then
		# src_prepare
		# Do not compile C extensions
		export LIBUNICORN_PATH=1

		pushd bindings/python >/dev/null || die
		distutils-r1_${1} "$@"
		popd >/dev/null || die
	fi
}

src_prepare() {
	# Build from sources
	rm -r bindings/python/prebuilt || die "failed to remove prebuilt files"

	cmake_src_prepare
	wrap_python ${FUNCNAME}

	if use elibc_musl ; then
		QA_CONFIG_IMPL_DECL_SKIP=( malloc_trim )
	fi
}

src_configure(){
	local mycmakeargs=(
		-DUNICORN_ARCH="${UNICORN_TARGETS// /;}"
		-DUNICORN_LOGGING=$(usex logging)
		-DUNICORN_LEGACY_STATIC_ARCHIVE=$(usex static-libs)
		-DZIG_BUILD=OFF
	)

	cmake_src_configure

	wrap_python ${FUNCNAME}
}

src_compile() {
	cmake_src_compile

	wrap_python ${FUNCNAME}
}

src_test() {
	cmake_src_install

	wrap_python ${FUNCNAME}
}

src_install() {
	cmake_src_install

	wrap_python ${FUNCNAME}
}
