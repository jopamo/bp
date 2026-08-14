# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 qa-policy toolchain-funcs flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end
DESCRIPTION="Python Imaging Library (fork)"
HOMEPAGE="https://python-pillow.org/"
SRC_URI="https://files.pythonhosted.org/packages/1c/3d/bb7fca845737cf9d7dbde16ed1843984665ff2e0a518f5db43e77ec540b9/pillow-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pillow-${PV}"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="jpeg jpeg2k lcms test tiff truetype webp xcb zlib"

REQUIRED_USE="test? ( jpeg jpeg2k lcms tiff truetype )"
RESTRICT="!test? ( test )"

DEPEND="
	dev-pypi/olefile[${PYTHON_USEDEP}]
	jpeg? ( xmedia-lib/libjpeg-turbo )
	jpeg2k? ( xmedia-lib/openjpeg )
	lcms? ( xgui-lib/lcms )
	tiff? ( xmedia-lib/tiff )
	truetype? (
		xgui-lib/freetype
		xgui-lib/harfbuzz
	)
	webp? ( xmedia-lib/libwebp )
	xcb? ( xgui-lib/libxcb )
	zlib? ( lib-core/zlib )
"
BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
	test? (
		dev-pypi/defusedxml[${PYTHON_USEDEP}]
		dev-pypi/packaging[${PYTHON_USEDEP}]
		dev-pypi/pytest-timeout[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

usepil() {
	usex "${1}" enable disable
}

src_prepare() {
	default

	sed -i '/^  "pybind11",$/d' pyproject.toml || die
}

python_configure_all() {
	filter-flags -Wl,-z,defs
	qa-policy-configure

	local pillow_configuration='configuration: dict[str, list[str]] = {'
	local feature
	for feature in \
		"platform-guessing:disable" \
		"freetype:$(usepil truetype)" \
		"raqm:disable" \
		"jpeg:$(usepil jpeg)" \
		"jpeg2000:$(usepil jpeg2k)" \
		"lcms:$(usepil lcms)" \
		"tiff:$(usepil tiff)" \
		"imagequant:disable" \
		"webp:$(usepil webp)" \
		"xcb:$(usepil xcb)" \
		"zlib:$(usepil zlib)" \
		"avif:disable"; do
		pillow_configuration+=$'\n    "'"${feature%%:*}"'": ["'"${feature#*:}"'"],'
	done
	pillow_configuration+=$'\n}'

	local -x PILLOW_CONFIGURATION="${pillow_configuration}"
	"${EPYTHON}" - <<'PY' || die
from pathlib import Path
import os

path = Path("setup.py")
source = path.read_text()
source = source.replace(
    "from pybind11.setup_helpers import ParallelCompile\n", "", 1
)
source = source.replace(
    'default = int(configuration.get("parallel", ["0"])[-1])\n'
    'ParallelCompile("MAX_CONCURRENCY", default).install()\n\n',
    "",
    1,
)
source = source.replace(
    "configuration: dict[str, list[str]] = {}",
    os.environ["PILLOW_CONFIGURATION"],
    1,
)
path.write_text(source)
PY
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
	qa-policy-install
}
