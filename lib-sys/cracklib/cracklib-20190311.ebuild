# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_OPTIONAL=1

SNAPSHOT=a1379d0081e14958b2ada6dcc1fcb7f128e4bd94

inherit autotools eutils distutils-r1 libtool toolchain-funcs

DESCRIPTION="Password Checking Library"
HOMEPAGE="https://github.com/cracklib/cracklib/"
SRC_URI="https://github.com/cracklib/cracklib/archive/${SNAPSHOT}.zip -> ${P}.zip"

S=${WORKDIR}/cracklib-${SNAPSHOT}/src
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls python static-libs zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="python? ( ${PYTHON_DEPS} )
	zlib? ( >=lib-sys/zlib-1.2.8-r1 )"
DEPEND="${RDEPEND}
	python? (
		dev-python/setuptools[${PYTHON_USEDEP}]
	)"

do_python() {
	use python || return 0
	pushd python > /dev/null || die
	distutils-r1_src_${EBUILD_PHASE}
	popd > /dev/null
}

pkg_setup() {
	# workaround #195017
	if has unmerge-orphans ${FEATURES} && has_version "<${CATEGORY}/${PN}-2.8.10" ; then
		eerror "Upgrade path is broken with FEATURES=unmerge-orphans"
		eerror "Please run: FEATURES=-unmerge-orphans emerge cracklib"
		die "Please run: FEATURES=-unmerge-orphans emerge cracklib"
	fi
}

src_prepare() {
	${S}/autogen.sh
	eautoreconf
	do_python
}

src_configure() {
	export ac_cv_header_zlib_h=$(usex zlib)
	export ac_cv_search_gzopen=$(usex zlib -lz no)
	# use /usr/lib so that the dictionary is shared between ABIs
	ECONF_SOURCE=${S} \
	econf \
		--with-default-dict='/usr/lib/cracklib_dict' \
		--without-python \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_compile() {
	default
	do_python
}

src_test() {
	# Make sure we load the freshly built library
	LD_LIBRARY_PATH="${BUILD_DIR}/lib/.libs" do_python
}

python_test() {
	${EPYTHON} -m unittest test_cracklib || die "Tests fail with ${EPYTHON}"
}

src_install() {
	default
	do_python
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict "${EPREFIX}"/usr/share/dict/* > /dev/null
		eend $?
	fi
}
