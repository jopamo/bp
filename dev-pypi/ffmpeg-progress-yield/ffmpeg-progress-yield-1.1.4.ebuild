# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="uv-build"

inherit distutils-r1

DESCRIPTION="Run an ffmpeg command with progress"
HOMEPAGE="https://github.com/slhck/ffmpeg-progress-yield"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d1/eb/a363add886230f72e69e671470607e76d7e80c796c63fff80e45a8696d2a/ffmpeg_progress_yield-1.1.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ffmpeg_progress_yield-1.1.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/tqdm
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/uv-build[${PYTHON_USEDEP}]
"
