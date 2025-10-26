# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Audio Normalization for Python/ffmpeg"
HOMEPAGE="https://github.com/slhck/ffmpeg-normalize"
SNAPSHOT=8ceb2a06e19042c69e3e1193af9262fae49afb27
SRC_URI="https://github.com/slhck/ffmpeg-normalize/archive/${SNAPSHOT}.tar.gz -> ffmpeg-normalize-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ffmpeg-normalize-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/ffmpeg-progress-yield[${PYTHON_USEDEP}]
"
