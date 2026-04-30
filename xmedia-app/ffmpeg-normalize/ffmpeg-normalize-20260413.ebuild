# Distributed under the terms of the GNU General Public License v2

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
SNAPSHOT=62dc6a15470dc5c52e39aa2ee0c16204a5c3bbc8
SRC_URI="https://github.com/slhck/ffmpeg-normalize/archive/${SNAPSHOT}.tar.gz -> ffmpeg-normalize-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ffmpeg-normalize-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/tqdm[${PYTHON_USEDEP}]
	dev-py/ffmpeg-progress-yield[${PYTHON_USEDEP}]
"
