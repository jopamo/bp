# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="uv-build"

inherit distutils-r1 pypi

DESCRIPTION="Run an ffmpeg command with progress"
HOMEPAGE="https://github.com/slhck/ffmpeg-progress-yield"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="ffmpeg-progress-yield"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/tqdm
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/uv-build[${PYTHON_USEDEP}]
"
