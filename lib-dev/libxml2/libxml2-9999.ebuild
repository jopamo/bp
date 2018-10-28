# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit libtool flag-o-matic python-r1 autotools prefix multilib-minimal

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64 x86"
IUSE="debug icu ipv6 lzma python readline static-libs"
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

PATCHES=(
	"${FILESDIR}"/${PN}-2.7.1-catalog_path.patch
	"${FILESDIR}"/${PN}-9999-python-ABIFLAG.patch
)

src_prepare() {
	default
	eprefixify catalog.c xmlcatalog.c runtest.c xmllint.c
	eautoreconf
}

multilib_src_configure() {
	libxml2_configure() {
		local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--with-html-subdir=${PF}/html \
		$(use_with debug run-debug)
		$(use_with icu)
		$(use_with lzma)
		$(use_enable ipv6)
		$(use_enable static-libs static)
		$(multilib_native_use_with readline)
		$(multilib_native_use_with readline history)
	)
		ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
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
	emake DESTDIR="${D}" EXAMPLES_DIR="${EPREFIX}"/usr/share/doc/${PF}/examples install

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
	rm -rf "${ED}"/usr/share/doc
	find "${ED}" -name "*.la" -delete || die
}

pkg_postinst() {
	if [[ "${ROOT}" != "/" ]]; then
		elog "Skipping XML catalog creation for stage building (bug #208887)."
	else
		CATALOG="${EROOT}etc/xml/catalog"

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
