# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

inherit autotools python-r1 toolchain-funcs multilib-minimal git-r3

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
EGIT_REPO_URI="https://github.com/GNOME/libxslt.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="crypt debug examples python static-libs elibc_Darwin"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	>=lib-dev/libxml2-2.9.1-r5:2[${MULTILIB_USEDEP}]
	crypt?  ( >=lib-dev/libgcrypt-1.5.3:0=[${MULTILIB_USEDEP}] )
	python? (
		${PYTHON_DEPS}
		lib-dev/libxml2:2[python,${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/xslt-config
)

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/libxslt/xsltconfig.h
)

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	libxslt_configure() {
		ECONF_SOURCE="${S}" econf \
			--with-html-dir="${EPREFIX}"/usr/share/doc/${PF} \
			--with-html-subdir=html \
			$(use_with crypt crypto) \
			$(use_with debug) \
			$(use_with debug mem-debug) \
			$(use_enable static-libs static) \
			"$@"
	}

	libxslt_py_configure() {
		mkdir -p "${BUILD_DIR}" || die # ensure python build dirs exist
		run_in_build_dir libxslt_configure --with-python
	}

	libxslt_configure --without-python # build python bindings separately

	if multilib_is_native_abi && use python; then
		python_foreach_impl libxslt_py_configure
	fi
}

multilib_src_compile() {
	default
	multilib_is_native_abi && use python && libxslt_foreach_py_emake all
}

multilib_src_test() {
	default
	multilib_is_native_abi && use python && libxslt_foreach_py_emake test
}

multilib_src_install() {
	# "default" does not work here - docs are installed by multilib_src_install_all
	emake DESTDIR="${D}" install

	if multilib_is_native_abi && use python; then
		libxslt_foreach_py_emake \
			DESTDIR="${D}" \
			docsdir="${EPREFIX}"/usr/share/doc/${PF}/python \
			EXAMPLE_DIR="${EPREFIX}"/usr/share/doc/${PF}/python/examples \
			install
		python_foreach_impl python_optimize
	fi
}

multilib_src_install_all() {
	rm -rf "${ED}"/usr/share/doc/${PF}/examples
	rm -rf "${ED}"/usr/share/doc/${PF}/python/examples

	find "${ED}" -name "*.la" -delete || die
}

libxslt_foreach_py_emake() {
	libxslt_py_emake() {
		pushd "${BUILD_DIR}/python" > /dev/null || die
		emake "$@"
		popd > /dev/null
	}
	local native_builddir=${BUILD_DIR}
	python_foreach_impl libxslt_py_emake top_builddir="${native_builddir}" "$@"
}
