# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517="uv-build"

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/colorlog
	dev-pypi/ffmpeg-progress-yield
	dev-pypi/mutagen
	dev-pypi/tqdm
"
# lockstep-pypi-deps: end
DESCRIPTION="Audio Normalization for Python/ffmpeg"
HOMEPAGE="https://github.com/slhck/ffmpeg-normalize"
SNAPSHOT=08876d1b9113e8a10ef1e5ba3cfd5e277324f8af
SRC_URI="https://github.com/slhck/ffmpeg-normalize/archive/${SNAPSHOT}.tar.gz -> ffmpeg-normalize-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ffmpeg-normalize-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-pypi/tqdm[${PYTHON_USEDEP}]
	dev-pypi/ffmpeg-progress-yield[${PYTHON_USEDEP}]
"
