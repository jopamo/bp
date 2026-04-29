# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Run an ffmpeg command with progress"
HOMEPAGE="https://github.com/slhck/ffmpeg-progress-yield"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/36/eb/f4836c4c30cef5f26cb0d77fa16938303665f87c1e0f64c2812d00706ecf/ffmpeg_progress_yield-1.1.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ffmpeg_progress_yield-1.1.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/tqdm
"
# lockstep-pypi-deps: end
