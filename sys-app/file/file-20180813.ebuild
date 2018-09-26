# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_OPTIONAL=1

inherit distutils-r1 libtool ltprune toolchain-funcs multilib-minimal autotools

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/file/file.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=473e039b48fd72660dd00f4b52a2880cc0dd5632
	SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
fi

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"

LICENSE="BSD-2"
SLOT="0"
IUSE="python static-libs zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	python? (
		${PYTHON_DEPS}
		dev-python/setuptools[${PYTHON_USEDEP}]
	)
	zlib? ( >=lib-sys/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )"
RDEPEND="${DEPEND}
	python? ( !dev-python/python-magic )"

src_prepare() {
	default

	eautoreconf
	elibtoolize
}

multilib_src_configure() {
	local myeconfargs=(
		--enable-fsect-man5
		$(use_enable static-libs static)
		$(use_enable zlib)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_configure() {
	# when cross-compiling, we need to build up our own file
	# because people often don't keep matching host/target
	# file versions #362941
	if tc-is-cross-compiler && ! ROOT=/ has_version ~${CATEGORY}/${P} ; then
		mkdir -p "${WORKDIR}"/build || die
		cd "${WORKDIR}"/build || die
		tc-export_build_env BUILD_C{C,XX}
		ECONF_SOURCE=${S} \
		ac_cv_header_zlib_h=no \
		ac_cv_lib_z_gzopen=no \
		CHOST=${CBUILD} \
		CFLAGS=${BUILD_CFLAGS} \
		CXXFLAGS=${BUILD_CXXFLAGS} \
		CPPFLAGS=${BUILD_CPPFLAGS} \
		LDFLAGS="${BUILD_LDFLAGS} -static" \
		CC=${BUILD_CC} \
		CXX=${BUILD_CXX} \
		econf --disable-shared
	fi

	multilib-minimal_src_configure
}

multilib_src_compile() {
	if multilib_is_native_abi ; then
		emake
	else
		cd src || die
		emake magic.h #586444
		emake libmagic.la
	fi
}

src_compile() {
	if tc-is-cross-compiler && ! ROOT=/ has_version "~${CATEGORY}/${P}" ; then
		emake -C "${WORKDIR}"/build/src magic.h #586444
		emake -C "${WORKDIR}"/build/src file
		PATH="${WORKDIR}/build/src:${PATH}"
	fi
	multilib-minimal_src_compile

	if use python ; then
		cd python || die
		distutils-r1_src_compile
	fi
}

multilib_src_install() {
	if multilib_is_native_abi ; then
		default
	else
		emake -C src install-{nodist_includeHEADERS,libLTLIBRARIES} DESTDIR="${D}"
	fi
}

multilib_src_install_all() {
	dodoc ChangeLog MAINT README

	if use python ; then
		cd python || die
		distutils-r1_src_install
	fi
	prune_libtool_files
}
