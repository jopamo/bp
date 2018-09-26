# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit libtool flag-o-matic ltprune python-r1 autotools prefix multilib-minimal

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64 x86"
IUSE="debug examples icu ipv6 lzma python readline static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GNOME/${PN}.git"
	S="${WORKDIR}/${PF}"
else
	SRC_URI="https://github.com/GNOME/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

RDEPEND="
	>=lib-sys/zlib-1.2.8-r1:=[${MULTILIB_USEDEP}]
	icu? ( >=lib-dev/icu-51.2-r1:=[${MULTILIB_USEDEP}] )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1:=[${MULTILIB_USEDEP}] )
	python? ( ${PYTHON_DEPS} )
	readline? ( lib-sys/readline:= )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	hppa? ( >=sys-devel/binutils-2.15.92.0.2 )
"

S="${WORKDIR}/${PN}-${PV%_rc*}"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/xml2-config
)

src_prepare() {
	default

	# Patches needed for prefix support
	eapply "${FILESDIR}"/${PN}-2.7.1-catalog_path.patch

	eprefixify catalog.c xmlcatalog.c runtest.c xmllint.c


	eapply "${FILESDIR}"/${PN}-9999-python-ABIFLAG.patch

	eautoreconf
}

multilib_src_configure() {
	libxml2_configure() {
		ECONF_SOURCE="${S}" econf \
			--with-html-subdir=${PF}/html \
			$(use_with debug run-debug) \
			$(use_with icu) \
			$(use_with lzma) \
			$(use_enable ipv6) \
			$(use_enable static-libs static) \
			$(multilib_native_use_with readline) \
			$(multilib_native_use_with readline history) \
			"$@"
	}

	libxml2_py_configure() {
		mkdir -p "${BUILD_DIR}" || die # ensure python build dirs exist
		run_in_build_dir libxml2_configure "--with-python=${ROOT%/}${PYTHON}" # odd build system, also see bug #582130
	}

	libxml2_configure --without-python # build python bindings separately

	if multilib_is_native_abi && use python; then
		python_foreach_impl libxml2_py_configure
	fi
}

multilib_src_compile() {
	default
	if multilib_is_native_abi && use python; then
		local native_builddir=${BUILD_DIR}
		python_foreach_impl libxml2_py_emake top_builddir="${native_builddir}" all
	fi
}

multilib_src_test() {
	emake check
	multilib_is_native_abi && use python && python_foreach_impl libxml2_py_emake test
}

multilib_src_install() {
	emake DESTDIR="${D}" \
		EXAMPLES_DIR="${EPREFIX}"/usr/share/doc/${PF}/examples install

	if multilib_is_native_abi && use python; then
		python_foreach_impl libxml2_py_emake \
			DESTDIR="${D}" \
			docsdir="${EPREFIX}"/usr/share/doc/${PF}/python \
			exampledir="${EPREFIX}"/usr/share/doc/${PF}/python/examples \
			install
		python_foreach_impl python_optimize
	fi
}

multilib_src_install_all() {
	# on windows, xmllint is installed by interix libxml2 in parent prefix.
	# this is the version to use. the native winnt version does not support
	# symlinks, which makes repoman fail if the portage tree is linked in
	# from another location (which is my default). -- mduft
	if [[ ${CHOST} == *-winnt* ]]; then
		rm -rf "${ED}"/usr/bin/xmllint
		rm -rf "${ED}"/usr/bin/xmlcatalog
	fi

	rm -rf "${ED}"/usr/share/doc/${P}
	einstalldocs

	if ! use examples; then
		rm -rf "${ED}"/usr/share/doc/${PF}/examples
		rm -rf "${ED}"/usr/share/doc/${PF}/python/examples
	fi

	prune_libtool_files --modules
}

pkg_postinst() {
	# We don't want to do the xmlcatalog during stage1, as xmlcatalog will not
	# be in / and stage1 builds to ROOT=/tmp/stage1root. This fixes bug #208887.
	if [[ "${ROOT}" != "/" ]]; then
		elog "Skipping XML catalog creation for stage building (bug #208887)."
	else
		# need an XML catalog, so no-one writes to a non-existent one
		CATALOG="${EROOT}etc/xml/catalog"

		# we dont want to clobber an existing catalog though,
		# only ensure that one is there
		# <obz@gentoo.org>
		if [[ ! -e ${CATALOG} ]]; then
			[[ -d "${EROOT}etc/xml" ]] || mkdir -p "${EROOT}etc/xml"
			"${EPREFIX}"/usr/bin/xmlcatalog --create > "${CATALOG}"
			einfo "Created XML catalog in ${CATALOG}"
		fi
	fi
}

libxml2_py_emake() {
	pushd "${BUILD_DIR}/python" > /dev/null || die
	emake "$@"
	popd > /dev/null
}
