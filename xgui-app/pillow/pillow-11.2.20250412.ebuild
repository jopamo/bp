# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2).x"
DISTUTILS_EXT=1

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 toolchain-funcs flag-o-matic

DESCRIPTION="Python Imaging Library (fork)"
HOMEPAGE="https://python-pillow.org/"
SNAPSHOT=339bc5db93bd95decf65a59fab273f300db6594d
SRC_URI="https://github.com/python-pillow/Pillow/archive/${SNAPSHOT}.tar.gz -> pillow-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Pillow-${SNAPSHOT}"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="imagequant jpeg jpeg2k lcms test tiff tk truetype webp xcb zlib"

REQUIRED_USE="test? ( jpeg jpeg2k lcms tiff truetype )"
RESTRICT="!test? ( test )"

DEPEND="
	xmedia-lib/libjpeg-turbo
	dev-python/olefile[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		dev-python/defusedxml[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

usepil() {
	usex "${1}" enable disable
}

src_prepare() {
	default

	sed -i '/^license[ ]*=.*/d;/^license-files[ ]*=.*/d' pyproject.toml || die

	sed -i '/^]/{
    	N
    	s/\(\n]\)/\1\nlicense = { text = "MIT-CMU" }/
	}' pyproject.toml || die
}

python_configure_all() {
	filter-flags -Wl,-z,defs
	cat >> setup.cfg <<-EOF || die
		[build_ext]
		debug = True
		disable_platform_guessing = True
		$(usepil truetype)_freetype = True
		$(usepil jpeg)_jpeg = True
		$(usepil jpeg2k)_jpeg2000 = True
		$(usepil lcms)_lcms = True
		$(usepil tiff)_tiff = True
		$(usepil imagequant)_imagequant = True
		$(usepil webp)_webp = True
		$(usepil xcb)_xcb = True
		$(usepil zlib)_zlib = True
	EOF
	if use truetype; then
		# these dependencies are implicitly disabled by USE=-truetype
		# and we can't pass both disable_* and vendor_*
		# https://bugs.gentoo.org/935124
		cat >> setup.cfg <<-EOF || die
			vendor_raqm = False
			vendor_fribidi = False
		EOF
	fi

	tc-export PKG_CONFIG
}

src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	local EPYTEST_DESELECT=(
		# TODO (is clipboard unreliable in Xvfb?)
		Tests/test_imagegrab.py::TestImageGrab::test_grabclipboard
		# requires xz-utils[extra-filters]?
		Tests/test_file_libtiff.py::TestFileLibTiff::test_lzma
	)

	"${EPYTHON}" selftest.py --installed || die "selftest failed with ${EPYTHON}"
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# leak tests are fragile and broken under xdist
	epytest -k "not leak" -p timeout || die "Tests failed with ${EPYTHON}"
}

python_install() {
	python_doheader src/libImaging/*.h
	distutils-r1_python_install
}
