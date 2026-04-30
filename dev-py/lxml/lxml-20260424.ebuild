# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature toolchain-funcs flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="https://lxml.de/"
SNAPSHOT=64ed06c1a0c1833bfac99f209f16c3bdfddfde79
SRC_URI="https://github.com/lxml/lxml/archive/${SNAPSHOT}.tar.gz -> lxml-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lxml-${SNAPSHOT}

LICENSE="BSD ElementTree GPL-2 PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="doc examples threads test"
RESTRICT="!test? ( test )"

# Note: lib{xml2,xslt} are used as C libraries, not Python modules.
DEPEND="
	>=lib-core/libxml2-2.10.3
	>=lib-core/libxslt-1.1.38
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	app-dev/pkgconf
	>=dev-py/cython-3.0.10[${PYTHON_USEDEP}]
	doc? (
		$(python_gen_any_dep '
			dev-py/docutils[${PYTHON_USEDEP}]
			dev-pypi/pygments[${PYTHON_USEDEP}]
			dev-pypi/sphinx[${PYTHON_USEDEP}]
			dev-py/sphinx-rtd-theme[${PYTHON_USEDEP}]
		')
	)
	test? (
		dev-pypi/cssselect[${PYTHON_USEDEP}]
	)
"

python_check_deps() {
	use doc || return 0
	python_has_version -b "dev-py/docutils[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-pypi/pygments[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-pypi/sphinx[${PYTHON_USEDEP}]" &&
	python_has_version -b "dev-py/sphinx-rtd-theme[${PYTHON_USEDEP}]"
}

python_prepare_all() {
	# don't use some random SDK on Darwin
	sed -i -e '/_ldflags =/s/=.*isysroot.*darwin.*None/= None/' \
		setupinfo.py || die

	distutils-r1_python_prepare_all
}

python_compile() {
	filter-flags -Wl,-z,defs
	append-flags -Wno-error
	local DISTUTILS_ARGS=(
		# by default it adds -w to CFLAGS
		--warnings
	)
	tc-export PKG_CONFIG
	distutils-r1_python_compile
}

python_compile_all() {
	use doc && emake html
}

python_test() {
	local dir=${BUILD_DIR}/test$(python_get_sitedir)/lxml
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}

	cp -al "${BUILD_DIR}"/{install,test} || die
	cp -al src/lxml/tests "${dir}/" || die
	cp -al src/lxml/html/tests "${dir}/html/" || die
	mkdir "${dir}"/../../doc || die
	# this one needs to be copied, because upstream uses doc/../../../doc
	cp -r "${S}"/doc "${dir}"/../../ || die
	ln -s "${S}"/doc "${dir}"/../../../../ || die

	"${EPYTHON}" test.py --no-src -vv --all-levels -p ||
		die "Tests fail on ${EPYTHON}"
}

python_install_all() {
	filter-flags -Wl,-z,defs
	if use doc; then
		local DOCS=( README.rst *.txt doc/*.txt )
		local HTML_DOCS=( doc/html/. )
	fi
	if use examples; then
		dodoc -r samples
	fi

	distutils-r1_python_install_all
}

pkg_postinst() {
	filter-flags -Wl,-z,defs
	optfeature "Support for BeautifulSoup as a parser backend" dev-pypi/beautifulsoup4
	optfeature "Translates CSS selectors to XPath 1.0 expressions" dev-pypi/cssselect
	optfeature "Support for lxml.html.clean sanitizer" dev-py/lxml-html-clean
}
